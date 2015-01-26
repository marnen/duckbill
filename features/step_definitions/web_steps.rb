Given /^I am on (.+)$/ do |page_name|
  visit path_to page_name
end

When /^I click "(.*?)"$/ do |name|
  click_on name
end

When 'I fill in the following:' do |table|
  table.rows_hash.each do |field, value|
    fill_in field, with: value
  end
end

Then /^I should be on (.+)$/ do |page_name|
  expect(current_path).to be == path_to(page_name)
end