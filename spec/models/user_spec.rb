require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :clients }
  it { should have_many(:projects).through :clients }
  it { should have_many(:time_entries).through :projects }

  [:date_format, :time_zone].each do |field|
    it { should validate_presence_of field }
  end

  describe '.resource_parameters' do
    subject { User.resource_parameters }

    [:name, :company, :email, :time_zone, :street, :city, :state, :zip].each do |field|
      it { should include field }
    end
  end
end
