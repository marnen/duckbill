require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :clients }
  it { should have_many(:projects).through :clients }
  it { should have_many(:time_entries).through :projects }

  it { should validate_presence_of :time_zone }

  describe '.resource_parameters' do
    subject { User.resource_parameters }

    [:name, :company, :email, :time_zone, :street, :city, :state, :zip].each do |field|
      it { should include field }
    end
  end
end
