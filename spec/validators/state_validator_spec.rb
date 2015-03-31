require 'rails_helper'

RSpec.describe StateValidator do
  subject { StateValidator.new attributes: Faker::Lorem.words(1).first }
  let(:options) { subject.options }

  it { should be_a_kind_of ActiveModel::Validations::LengthValidator }

  context 'nil and blank' do
    ['blank', 'nil'].each do |value|
      it "allows #{value}" do
        expect(options[:"allow_#{value}"]).to be == true
      end
    end
  end

  context 'otherwise' do
    it 'ensures that the length is exactly 2' do
      expect(options[:is]).to be == 2
    end
  end
end
