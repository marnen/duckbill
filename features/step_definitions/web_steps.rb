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

When /^I go to (.+)$/ do |page_name|
  visit path_to page_name
end

When /^(.+) within (.+)$/ do |step_text, selector|
  within selector_for(selector) do
    step step_text
  end
end

Then /^I should be on (.+)$/ do |page_name|
  expect(current_path).to be == path_to(page_name)
end

Then /^I should not be allowed to go to (.+)$/ do |page_name|
  expect { visit path_to page_name }.to raise_error CanCan::AccessDenied
end

Then /^I should (not )?see "(.*?)"$/ do |negation, content|
  expect(page.has_text? content).to be == !negation
end