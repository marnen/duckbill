Then(/^I should (not )?see the following project:$/) do |negation, table|
  within '.project' do
    table.rows_hash.each do |field, value|
      expect(page.has_selector? ".#{field.delete(' ').underscore}", text: value).to be == !negation
    end
  end
end