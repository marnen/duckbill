Given /^I have no (.+)$/ do |association|
  @current_user.send(remove_spaces association).destroy_all
end

Given /^I have (\d+|an?) (.+)/ do |count, association|
  count = 1 if ['a', 'an'].include? count
  count.times do
    FactoryGirl.create normalize(association), user: @current_user
  end
end

Given /^the following (.+) exists:$/ do |model, table|
  association_fields = {'client' => :name, 'user' => :email}
  params = table.hashes.first
  association_fields.each do |association, field|
    params[association] &&= class_for(association).where(field => params[association]).first
  end
  model = normalize model
  self.instance_variable_set "@#{model}", FactoryGirl.create(model, params)
end

Given /^I have the following (.+):$/ do |model, table|
  table.hashes.each {|hash| create_for_current_user model, hash }
end

private

def class_for(string)
  normalize(string).camelize.constantize
end

def create_for_current_user(model, params)
  model = normalize model
  parent_fields = {'time_entry' => 'project', 'project' => 'client'}
  additional_options = {'client' => :with_name_and_address}
  parent = parent_fields[model]
  if params.include? parent
    params[parent] = @current_user.send(parent.pluralize).find_by_name params[parent]
  else
    params['user'] = @current_user
  end
  FactoryGirl.create *[model, additional_options[model], params].compact
end

def normalize(string)
  remove_spaces(string).downcase.singularize
end

def remove_spaces(string)
  string.gsub ' ', '_'
end
