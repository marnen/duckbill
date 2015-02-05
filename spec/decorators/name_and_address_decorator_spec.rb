require 'rails_helper'

class AddressedModel < OpenStruct
  include Draper::Decoratable
end

class AddressedModelDecorator < Draper::Decorator
  include NameAndAddressDecorator
end

FactoryGirl.define do
  factory :addressed_model do
  end
end

describe NameAndAddressDecorator do
  describe '#name_and_address' do
    let(:model) { FactoryGirl.build :addressed_model, :with_name_and_address, {email: Faker::Internet.email}.merge(options) }
    let(:name_and_address) { model.decorate.name_and_address }

    context 'full name and address' do
      let(:options) { {} }

      it 'joins the address components together with linebreaks' do
        expect(name_and_address).to be == <<-"END".strip
#{model.name}
#{model.company}
#{model.email}
#{model.street}
#{model.city}, #{model.state} #{model.zip}
        END
      end
    end

    context 'line element missing' do
      let(:options) { {company: nil} }

      it 'does not render a blank line' do
        expect(name_and_address).to start_with "#{model.name}\n#{model.email}"
      end
    end

    context 'line element blank' do
      let(:options) { {street: ' '} }

      it 'does not render a blank line' do
        expect(name_and_address).to include "#{model.email}\n#{model.city}"
      end
    end

    context 'city, state, and zip all missing' do
      let(:options) { {city: ' ', state: nil, zip: ' '} }

      it 'does not render commas and spaces' do
        expect(name_and_address).to end_with model.street
      end
    end
  end
end