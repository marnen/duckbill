require 'rails_helper'

RSpec.describe TimeEntry, :type => :model do
  it { should belong_to :user }

  [:user_id, :date, :hours, :description].each do |field|
    it { should validate_presence_of field }
  end
end
