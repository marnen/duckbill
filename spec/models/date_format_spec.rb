require 'rails_helper'

describe DateFormat do
  describe '#key' do
    it 'returns the key' do
      key = Faker::Lorem.sentence
      expect(DateFormat.new(key).key).to be == key
    end
  end

  describe '#to_s' do
    let(:string) { Faker::Lorem.sentence }

    context 'value matches a key in Date::DATE_FORMATS' do
      it 'returns the format string from that key' do
        key = Faker::Lorem.words(1).first
        stub_const 'Date::DATE_FORMATS', {key.to_sym => string}

        expect(DateFormat.new(key).to_s).to be == string
      end
    end

    context 'value does not match a key in Date::DATE_FORMATS' do
      it 'returns the value' do
        stub_const 'Date::DATE_FORMATS', {}

        expect(DateFormat.new(string).to_s).to be == string
      end
    end
  end
end