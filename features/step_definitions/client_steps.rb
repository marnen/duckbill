Then /^I should (not )?see the following client:$/ do |negation, table|
  within '.client' do
    table.rows_hash.each do |field, value|
      expect(page.has_selector? ".#{field.delete(' ').underscore}", text: value).to be == !negation
    end
  end
end
