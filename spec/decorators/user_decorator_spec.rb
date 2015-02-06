require 'rails_helper'

describe UserDecorator do
  subject { User.new.decorate }

  it { should be_a_kind_of NameAndAddressDecorator }
end