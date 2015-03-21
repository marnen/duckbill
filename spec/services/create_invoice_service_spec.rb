require 'rails_helper'

describe CreateInvoiceService, versioning: true do
  let(:call_service!) { CreateInvoiceService.call invoice }

  describe '.call' do
    let(:invoice) { FactoryGirl.build :invoice }

    it 'saves the invoice' do
      expect(invoice).to receive(:save).and_return true
      call_service!
    end

    context 'record management' do
      let(:project) { FactoryGirl.create :project }
      let(:invoice) { FactoryGirl.build :invoice, project: project }

      context 'time entry management' do
        it "assigns all uninvoiced time entries for the project to the new invoice" do
          time_entry = FactoryGirl.create :time_entry, project: project, invoice: nil

          call_service!
          expect(time_entry.reload.invoice_id).to be == invoice.id
        end

        it "does not alter time entries for other projects" do
          other_project = FactoryGirl.create :project
          other_invoice = FactoryGirl.create :invoice, project: other_project
          invoiced = FactoryGirl.create :time_entry, project: other_project, invoice: other_invoice
          uninvoiced = FactoryGirl.create :time_entry, project: other_project, invoice: nil

          call_service!
          expect(invoiced.reload.invoice).to be == other_invoice
          expect(uninvoiced.reload.invoice).to be_nil
        end

        it "does not alter already invoiced time entries" do
          old_invoice = FactoryGirl.create :invoice, project: project
          time_entry = FactoryGirl.create :time_entry, project: project, invoice: old_invoice

          call_service!
          expect(time_entry.reload.invoice_id).to be == old_invoice.id
        end
      end

      describe 'version management' do
        [:client, :project].each do |association|
          context association.to_s do
            it "creates a #{association} version" do
              expect { call_service! }.to change { invoice.send(association).versions.count }.by 1
            end

            it 'stores the version in the invoice' do
              call_service!
              expect(invoice["#{association}_version_id"]).to be == invoice.send(association).versions.last.id
            end
          end
        end
      end
    end
  end
end