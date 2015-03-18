include ModelNameHelpers

Given /^I have no (#{model_names})$/ do |association|
  @current_user.send(remove_spaces association).destroy_all
end

Given /^I have (\d+|an?) (#{model_names})$/ do |count, association|
  count = 1 if ['a', 'an'].include? count
  model = normalize(association)
  count.times do
    memoize model, FactoryGirl.create(model, user: @current_user)
  end
end

Given /^the following (#{model_names}) exists:$/ do |model, table|
  association_fields = {'client' => :name, 'user' => :email}
  params = table.hashes.first
  association_fields.each do |association, field|
    params[association] &&= class_for(association).where(field => params[association]).first
  end
  model = normalize model
  memoize model, FactoryGirl.create(model, params)
end

Given /^I have the following (#{model_names}):$/ do |model, table|
  table.hashes.each {|hash| create_for_current_user model, hash }
end

private

def create_for_current_user(model, params)
  model = normalize model
  parent_fields = {
    'invoice' => 'project',
    'time_entry' => 'project',
    'project' => 'client'
  }
  additional_options = {'client' => :with_name_and_address}
  parent = parent_fields[model]
  if params.include? parent
    parent_collection = @current_user.send(parent.pluralize)
    parent_name = params[parent]
    parent_object = parent_collection.find_by_name(parent_name) || create_for_current_user(parent, 'name' => parent_name)
    params[parent] = parent_object
  else
    params['user'] = @current_user
  end
  params.transform_keys! {|key| remove_spaces key }
  memoize model, FactoryGirl.create(*[model, additional_options[model], params].compact)
end

def memoize(name, value)
  self.instance_variable_set "@#{name}", value
end
