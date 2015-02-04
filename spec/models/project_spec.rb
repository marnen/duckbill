require 'rails_helper'

RSpec.describe Project, :type => :model do
  it { should belong_to :client }

  [:client_id, :name].each do |field|
    it { should validate_presence_of field }
  end

  describe 'permissions' do
    subject(:ability) { Ability.new user }
    let(:project) { FactoryGirl.create :project }

    context 'owner of client' do
      let(:user) { project.client.user }

      it { should be_able_to :manage, project}
    end

    context 'other user' do
      let(:user) { User.new }

      [:create, :read, :update, :destroy].each do |action|
        it { should_not be_able_to action, project}
      end
    end
  end
end
