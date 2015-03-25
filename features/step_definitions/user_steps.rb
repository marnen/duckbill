Given /^a user exists with email: "(.*?)"$/ do |email|
  FactoryGirl.create :user, email: email
end

Given /^I am logged in(?: as "(.*?)")?$/ do |email|
  params = email ? {email: email} : {}
  @current_user = FactoryGirl.create :user, :with_name_and_address, params
  login_as @current_user
end

Given 'I am logged in as the following user:' do |table|
  @current_user = FactoryGirl.create :user, params_from(table)
  login_as @current_user
end

Given 'I am not logged in' do
  visit destroy_user_session_path
end

Given 'no users exist' do
  User.destroy_all
end

When /^I change my name to "(.*?)"$/ do |name|
  @current_user.update_attributes! name: name
end

Then /^I should see my (.+)$/ do |field|
  field.downcase!
  field =~ /^e-mail\b/ ? field = 'email' : field.gsub!(/\s/, '_')
  expect(page).to have_content @current_user[field]
end
