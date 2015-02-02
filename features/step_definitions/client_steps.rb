Given 'I have no clients' do
  @current_user.clients.destroy_all
end

Given 'the following client exists:' do |table|
  params = table.rows_hash.transform_keys &:downcase
  params['user'] = User.find_by_email(params['user']) if params.include? 'user'
  @client = FactoryGirl.create :client, params
end


Then /^I should (not )?see the following client:$/ do |negation, table|
  within '.client' do
    table.rows_hash.each do |field, value|
      expect(page.has_selector? ".#{field.delete(' ').underscore}", text: value).to be == !negation
    end
  end
end
