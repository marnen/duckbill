Given /^I have no (.+)$/ do |association|
  @current_user.send(association.gsub(' ', '_')).destroy_all
end

Given /^I have (\d+|an?) (.+)/ do |count, association|
  count = 1 if ['a', 'an'].include? count
  count.times do
    FactoryGirl.create association.gsub(' ', '_').singularize, user: @current_user
  end
end

Given 'the following client exists:' do |table|
  params = params_from table
  params['user'] = User.find_by_email(params['user']) if params.include? 'user'
  @client = FactoryGirl.create :client, params
end

Given 'I have the following client:' do |table|
  params = params_from(table).merge user: @current_user
  @client = FactoryGirl.create :client, :with_name_and_address, params
end

Given 'I have the following invoice:' do |table|
  hash = table.hashes.first
  if hash['project']
    hash['project'] = @current_user.projects.find_by_name(hash['project']) || FactoryGirl.create(:project, user: @current_user, name: hash['project'])
  else
    hash['user'] = @current_user
  end
  @invoice = FactoryGirl.create :invoice, hash
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

Given 'I have the following time entries:' do |table|
  table.hashes.each do |hash|
    hash['project'] = @current_user.projects.find_by_name hash['project']
    FactoryGirl.create :time_entry, hash
  end
end

Given 'the following time entry exists:' do |table|
  params = table.rows_hash.transform_keys &:downcase
  params['user'] = User.find_by_email(params['user']) if params.include? 'user'
  @time_entry = FactoryGirl.create :time_entry, params
end

