Given 'I have no clients' do
  @current_user.clients.destroy_all
end

Given /^I have (\d+) clients?$/ do |count|
  count.times do
    FactoryGirl.create :client, user: @current_user
  end
end

Given 'the following client exists:' do |table|
  params = params_from table
  params['user'] = User.find_by_email(params['user']) if params.include? 'user'
  @client = FactoryGirl.create :client, params
end

Given 'I have the following client:' do |table|
  params = params_from(table).merge user: @current_user
  @client = FactoryGirl.create :client, params
end


Then /^I should (not )?see the following client:$/ do |negation, table|
  within '.client' do
    table.rows_hash.each do |field, value|
      expect(page.has_selector? ".#{field.delete(' ').underscore}", text: value).to be == !negation
    end
  end
end

private

def params_from(table)
  table.rows_hash.transform_keys &:downcase
end
