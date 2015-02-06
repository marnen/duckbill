Given 'I have no projects' do
  @current_user.projects.destroy_all
end

Given 'I have the following project:' do |table|
  params = params_from table
  @project = FactoryGirl.create :project, params.merge(user: @current_user)
end

Given 'I have the following projects:' do |table|
  table.hashes.each do |hash|
    client = hash['client'] ? @current_user.clients.find_by_name(hash['client']) : FactoryGirl.create(:client, user: @current_user)
    FactoryGirl.create :project, hash.merge('client' => client)
  end
end

Given 'the following project exists:' do |table|
  params = params_from table
  params['client'] = Client.find_by_name(params['client']) if params.include? 'client'
  @project = FactoryGirl.create :project, params
end

Then(/^I should (not )?see the following project:$/) do |negation, table|
  within '.project' do
    table.rows_hash.each do |field, value|
      expect(page.has_selector? ".#{field.delete(' ').underscore}", text: value).to be == !negation
    end
  end
end