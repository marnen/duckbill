Given 'I have no projects' do
  @current_user.projects.destroy_all
end

Given 'the following project exists:' do |table|
  params = params_from table
  params['client'] = Client.find_by_name(params['client']) if params.include? 'client'
  @project = FactoryGirl.create :project, params
end

Then(/^I should see the following project:$/) do |table|
  within '.project' do
    table.rows_hash.each do |field, value|
      expect(page).to have_selector ".#{field.delete(' ').underscore}", text: value
    end
  end
end