require 'rails_helper'

describe CreateInvoiceService do
  describe '.call' do
    it 'saves the invoice' do
      invoice = FactoryGirl.build :invoice
      expect(invoice).to receive(:save).and_return true
      CreateInvoiceService.call invoice
    end

    context 'time entry management' do
      let(:project) { FactoryGirl.create :project }
      let(:invoice) { FactoryGirl.build :invoice, project: project }

      it "assigns all uninvoiced time entries for the project to the new invoice" do
        time_entry = FactoryGirl.create :time_entry, project: project, invoice: nil

        CreateInvoiceService.call invoice
        expect(time_entry.reload.invoice_id).to be == invoice.id
      end

      it "does not alter time entries for other projects" do
        other_project = FactoryGirl.create :project
        other_invoice = FactoryGirl.create :invoice, project: other_project
        invoiced = FactoryGirl.create :time_entry, project: other_project, invoice: other_invoice
        uninvoiced = FactoryGirl.create :time_entry, project: other_project, invoice: nil

        CreateInvoiceService.call invoice
        expect(invoiced.reload.invoice).to be == other_invoice
        expect(uninvoiced.reload.invoice).to be_nil
      end

      it "does not alter already invoiced time entries" do
        old_invoice = FactoryGirl.create :invoice, project: project
        time_entry = FactoryGirl.create :time_entry, project: project, invoice: old_invoice

        CreateInvoiceService.call invoice
        expect(time_entry.reload.invoice_id).to be == old_invoice.id
      end
    end
  end
end