require 'rails_helper'

RSpec.describe Client, :type => :model do
  it { should belong_to :user }
  it { should validate_presence_of :user_id }

  describe 'permissions' do
    subject(:ability) { Ability.new user }
    let(:client) { FactoryGirl.create :client }

    context 'creator' do
      let(:user) { client.user }

      it { should be_able_to :manage, client}
    end

    context 'other user' do
      let(:user) { instance_double 'User', id: client.user_id + (rand(1..100) * [1, -1].shuffle.first) }

      [:create, :read, :update, :destroy].each do |action|
        it { should_not be_able_to action, client}
      end
    end
  end

end