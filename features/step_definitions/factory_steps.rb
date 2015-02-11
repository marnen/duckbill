Given /^I have no (.+)$/ do |association|
  @current_user.send(remove_spaces association).destroy_all
end

Given /^I have (\d+|an?) (.+)/ do |count, association|
  count = 1 if ['a', 'an'].include? count
  count.times do
    FactoryGirl.create remove_spaces(association).singularize, user: @current_user
  end
end

Given /^the following (.+) exists:$/ do |model, table|
  association_fields = {'client' => :name, 'user' => :email}
  params = table.hashes.first
  association_fields.each do |association, field|
    if params.include? association
      association_class = remove_spaces(association).camelize.constantize
      params[association] = association_class.where(field => params[association]).first
    end
  end
  underscored_model = remove_spaces model
  self.instance_variable_set "@#{underscored_model}", FactoryGirl.create(underscored_model, params)
end

Given 'I have the following client:' do |table|
  params = table.hashes.first.merge user: @current_user
  @client = FactoryGirl.create :client, :with_name_and_address, params
end

Given /^I have the following projects?:$/ do |table|
  table.hashes.each do |hash|
    client = hash['client'] ? @current_user.clients.find_by_name(hash['client']) : FactoryGirl.create(:client, user: @current_user)
    FactoryGirl.create :project, hash.merge('client' => client)
  end
end

Given 'I have the following time entries:' do |table|
  table.hashes.each do |hash|
    hash['project'] = @current_user.projects.find_by_name hash['project']
    FactoryGirl.create :time_entry, hash
  end
end

private

def remove_spaces(string)
  string.gsub ' ', '_'
end
