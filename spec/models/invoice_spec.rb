require 'rails_helper'

RSpec.describe Invoice, :type => :model do
  let(:invoice) { FactoryGirl.create :invoice }

  it { should belong_to :project }
  it { should have_one(:client).through :project }
  it { should have_one(:user).through :client }
  it { should have_many :time_entries }

  it { should validate_presence_of :project_id }

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

  describe '#number' do
    it "returns the invoice's ID for now" do
      expect(invoice.number).to be == invoice.id
    end

    # TODO
    it "should eventually return a number separate from the invoice's ID"
  end
end
