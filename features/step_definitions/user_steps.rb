Given /^a user exists with email: "(.*?)"$/ do |email|
  FactoryGirl.create :user, email: email
end

Given /^I am logged in(?: as "(.*?)")?$/ do |email|
  params = email ? {email: email} : {}
  @current_user = FactoryGirl.create :user, params
  visit new_user_session_path
  fill_in 'Email', with: @current_user.email
  fill_in 'Password', with: @current_user.password
  within('form') { click_on 'Log in' }
end

Given 'I am not logged in' do
  visit destroy_user_session_path
end

Given 'no users exist' do
  User.destroy_all
end
