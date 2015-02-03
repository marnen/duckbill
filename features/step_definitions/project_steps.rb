Then(/^I should see the following project:$/) do |table|
  within '.project' do
    table.rows_hash.each do |field, value|
      expect(page).to have_selector ".#{field.delete(' ').underscore}", text: value
    end
  end
end