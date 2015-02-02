require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :clients }
  it { should have_many :time_entries }
end
