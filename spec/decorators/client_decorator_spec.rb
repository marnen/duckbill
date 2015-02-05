require 'rails_helper'

describe ClientDecorator do
  subject { Client.new.decorate }

  it { should be_a_kind_of NameAndAddressDecorator }
end