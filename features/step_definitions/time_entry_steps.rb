Given 'I have no time entries' do
  @current_user.time_entries.destroy_all
end

Given 'the following time entry exists:' do |table|
  params = table.rows_hash.transform_keys &:downcase
  params['user'] = User.find_by_email(params['user']) if params.include? 'user'
  FactoryGirl.create :time_entry, params
end

Then 'I should see a time entry for:' do |table|
  within '.time_entry' do
    table.rows_hash.each do |field, value|
      expect(page).to have_selector ".#{field.delete(' ').underscore}", text: value
    end
  end
end