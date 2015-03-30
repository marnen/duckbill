RSpec.shared_examples 'state validation' do
  it { should validate_length_of(:state).is_equal_to 2 }
  it { should allow_value(nil, '').for :state }
end
