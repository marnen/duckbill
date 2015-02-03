require 'rails_helper'

RSpec.describe Project, :type => :model do
  it { should belong_to :client }

  [:client_id, :name].each do |field|
    it { should validate_presence_of field }
  end
end
