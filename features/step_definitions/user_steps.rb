Given /^a user exists with email: "(.*?)"$/ do |email|
  FactoryGirl.create :user, email: email
end

Given /^I am logged in(?: as "(.*?)")?$/ do |email|
  params = email ? {email: email} : {}
  @current_user = FactoryGirl.create :user, params
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
