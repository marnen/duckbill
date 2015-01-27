require 'rails_helper'

RSpec.describe TimeEntry, :type => :model do
  it { should belong_to :user }

  [:user_id, :date, :hours, :description].each do |field|
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
      let(:user) { instance_double 'User', id: time_entry.user_id + (rand(1..100) * [1, -1].shuffle.first) }

      [:create, :read, :update, :destroy].each do |action|
        it { should_not be_able_to action, time_entry}
      end
    end
  end
end
