require 'rails_helper'

RSpec.describe Invoice, :type => :model do
  let(:invoice) { FactoryGirl.create :invoice }

  it { should belong_to :project }
  it { should have_one(:client).through :project }
  it { should have_one(:user).through :client }
  it { should have_many :time_entries }
  [:client_version, :project_version].each do |version|
    it { should belong_to(version).class_name PaperTrail::Version }
  end

  [:client_version_id, :project_id, :project_version_id].each do |field|
    it { should validate_presence_of field }
  end

  describe 'permissions' do
    subject(:ability) { Ability.new user }

    context 'creator' do
      let(:user) { invoice.user }

      it { should be_able_to :manage, invoice}
    end

    context 'other user' do
      let(:user) { instance_double 'User', id: invoice.project.client.user.id + (rand(1..100) * [1, -1].shuffle.first) }

      [:create, :read, :update, :destroy].each do |action|
        it { should_not be_able_to action, invoice}
      end
    end
  end

  describe 'version handling', versioning: true do
    before(:each) { invoice.capture_association_versions! }

    describe '#capture_association_versions!' do
      [:client, :project].each do |association|
        it 'associates a project version with the invoice' do
          expect(invoice["#{association}_version_id"]).to be == invoice.send(association).versions.last.id
        end
      end
    end

    describe '#snapshot' do
      before(:each) { invoice.save! }

      [:client, :project].each do |association|
        describe association do
          it "returns the #{association} version associated with the invoice" do
            record = invoice.send association
            record.update_attributes! name: 'New name'
            record.touch_with_version
            expect(invoice.snapshot(association).attributes).to be == invoice.send("#{association}_version").reify.attributes
          end
        end
      end
    end
  end

  describe '.with_time_entries' do
    subject { Invoice.with_time_entries.where(id: invoice.id).to_sql }

    it "fetches the invoice's time entries along with the invoice" do
      expect(subject).to be =~ %r{\b(?i:left (outer )?join )#{Regexp::escape TimeEntry.quoted_table_name}}
    end

    it 'fetches the client along with the invoice' do
      [Project, Client].each do |klass|
        expect(subject).to be =~ %r{\b(?i:join )#{Regexp::escape klass.quoted_table_name}}
      end
    end
  end

  describe '#number' do
    it "returns the invoice's ID for now" do
      expect(invoice.number).to be == invoice.id
    end

    # TODO
    it "should eventually return a number separate from the invoice's ID"
  end
end
