require 'rails_helper'

RSpec.describe TimeEntry, :type => :model do
  it { should belong_to :project }
  it { should have_one(:user).through :project }

  [:project_id, :date, :hours, :description].each do |field|
    it { should validate_presence_of field }
  end

  describe 'permissions' do
    subject(:ability) { Ability.new user }
    let(:time_entry) { FactoryGirl.create :time_entry }

    context 'creator' do
      let(:user) { time_entry.user }

      it { should be_able_to :manage, time_entry}
    end

    context 'other user' do
      let(:user) { instance_double 'User', id: time_entry.user.id + (rand(1..100) * [1, -1].shuffle.first) }

      [:create, :read, :update, :destroy].each do |action|
        it { should_not be_able_to action, time_entry}
      end
    end
  end

  describe '.resource_params' do
    subject { TimeEntry.resource_params }

    [:project_id, :date, :hours, :description, :notes].each do |field|
      it { should include field }
    end
  end
end
