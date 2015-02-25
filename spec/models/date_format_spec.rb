require 'rails_helper'

describe DateFormat do
  [:key, :to_s].each do |method|
    describe "##{method}" do
      it 'returns the key' do
        key = Faker::Lorem.sentence
        stub_const 'Date::DATE_FORMATS', {key.to_sym => Faker::Lorem.sentence}
        expect(DateFormat.new(key).send method).to be == key
      end
    end
  end

  describe '#format' do
    let(:string) { Faker::Lorem.sentence }
    let(:date) do
      rand(100).days.from_now.tap {|date| allow(date).to receive :strftime }
    end

    context 'value matches a key in Date::DATE_FORMATS' do
      it 'formats the date with the format string from that key' do
        key = Faker::Lorem.words(1).first
        stub_const 'Date::DATE_FORMATS', {key.to_sym => string}

        DateFormat.new(key).format date
        expect(date).to have_received(:strftime).with string
      end
    end

    context 'value does not match a key in Date::DATE_FORMATS' do
      it 'returns the value' do
        stub_const 'Date::DATE_FORMATS', {}

        DateFormat.new(string).format date
        expect(date).to have_received(:strftime).with string
      end
    end
  end
end