Then /^I should (not )?see a time entry for:$/ do |negation, table|
  within '.time_entry' do
    table.rows_hash.each do |field, value|
      expect(page.has_selector? ".#{field.delete(' ').underscore}", text: value).to be == !negation
    end
  end
end