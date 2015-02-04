require 'rails_helper'

RSpec.describe Invoice, :type => :model do
  it { should belong_to :project }
  it { should have_one(:client).through :project }
  it { should have_many :time_entries }
end
