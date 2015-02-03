require 'rails_helper'
require 'foundation_form_builder'

describe FoundationFormBuilder, type: :view do
  let(:object_name) { Faker::Lorem.words(rand 1..3).join('_') }
  let(:object) { double(object_name.camelize).as_null_object }
  subject(:builder) { FoundationFormBuilder.new object_name, object, view, {} }

  it { should be_a_kind_of ActionView::Helpers::FormBuilder }

  describe '#input_div' do
    let(:field_name) { Faker::Lorem.words(rand 1..3).join('_').to_sym }
    let(:input_id) { [object_name, field_name].join '_' }
    let(:input_name) { "#{object_name}[#{field_name}]" }
    let(:wrapper) { "div.#{field_name}" }
    subject(:input_div) { builder.input_div field_name }

    it { should be_html_safe }

    it 'wraps the whole thing in a div with a class named for the field' do
      expect(input_div).to have_tag wrapper, count: 1
    end

    it 'renders a label within the wrapper' do
      expect(input_div).to have_tag "#{wrapper} label[for='#{input_id}']", text: field_name.to_s.humanize
    end

    it 'renders the field within the wrapper' do
      expect(input_div).to have_tag "#{wrapper} input##{input_id}[type='text'][name='#{input_name}']"
    end

    describe 'errors' do
      context 'nil' do
        it 'does not render an error element' do
          expect(input_div).not_to have_tag "#{wrapper} .error"
        end
      end

      context 'present' do
        let(:error_message) { Faker::Lorem.sentence }

        before(:each) do
          allow(builder).to receive(:error_message_on).with(field_name).and_return error_message
        end

        it 'renders an error element' do
          expect(input_div).to have_tag "#{wrapper} .error", text: error_message
        end
      end
    end

    describe 'field type' do
      let(:column) { instance_double ActiveRecord::ConnectionAdapters::Column }

      before(:each) do
        allow(column).to receive(:type).and_return type
        allow(object).to receive(:column_for_attribute).with(field_name).and_return column
      end

      context 'text' do
        let(:type) { :text }

        it 'renders a text area' do
          expect(input_div).to have_tag "#{wrapper} textarea##{input_id}"
        end
      end

      context 'date' do
        let(:type) { :date }

        it 'renders a date field' do
          expect(input_div).to have_tag "#{wrapper} input##{input_id}[type='date']"
        end
      end
    end
  end
end