Given 'I am logged in' do
  @current_user = FactoryGirl.create :user
  visit new_user_session_path
  fill_in 'Email', with: @current_user.email
  fill_in 'Password', with: @current_user.password
  click_on 'Log in'
end