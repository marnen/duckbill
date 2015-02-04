Given 'I have no time entries' do
  @current_user.time_entries.destroy_all
end

Given /^I have (\d+) time entr(?:y|ies)$/ do |count|
  count.times do
    FactoryGirl.create :time_entry, user: @current_user
  end
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

Then /^I should (not )?see a time entry for:$/ do |negation, table|
  within '.time_entry' do
    table.rows_hash.each do |field, value|
      expect(page.has_selector? ".#{field.delete(' ').underscore}", text: value).to be == !negation
    end
  end
end