require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :clients }
  it { should have_many(:projects).through :clients }
  it { should have_many(:time_entries).through :projects }

  [:date_format, :time_zone].each do |field|
    it { should validate_presence_of field }
  end

  describe 'aggregations' do
    describe 'date_format' do
      let(:date_format) { User.reflect_on_aggregation :date_format }

      it 'does not instantiate on nil' do
        expect(date_format.options[:allow_nil]).to be == true
      end

      it 'has a converter' do
        expect(date_format.options[:converter]).to be_present
      end
    end
  end

  describe '.resource_parameters' do
    subject { User.resource_parameters }

    [:name, :company, :email, :time_zone, :date_format, :street, :city, :state, :zip].each do |field|
      it { should include field }
    end
  end
end
