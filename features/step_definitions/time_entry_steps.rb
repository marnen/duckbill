Given 'I have no time entries' do
  @current_user.time_entries.destroy_all
end

Then 'I should see a time entry for:' do |table|
  within '.time_entry' do
    table.rows_hash.each do |field, value|
      page.should have_selector ".#{field.delete(' ').underscore}", text: value
    end
  end
end