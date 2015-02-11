Given /^I am on (.+)$/ do |page_name|
  visit path_to page_name
end

When /^I click "(.*?)"$/ do |name|
  click_on name
end

When 'I fill in the following:' do |table|
  table.rows_hash.each do |field, value|
    begin
      fill_in field, with: value
    rescue Capybara::ElementNotFound
      select value, from: field
    end
  end
end

When /^I go to (.+)$/ do |page_name|
  visit path_to page_name
end

When /^I select "(.*?)" from "(.*?)"$/ do |value, field|
  select value, from: field
end

When /^(.+) within (.+)$/ do |step_text, element|
  within selector_for(element) do
    step step_text
  end
end

Then /^I should be on (.+)$/ do |page_name|
  expect(path_to page_name).to be === current_path
end

Then /^I should not be allowed to go to (.+)$/ do |page_name|
  expect { visit path_to page_name }.to raise_error CanCan::AccessDenied
end

Then /^I should (not )?see "(.*?)"$/ do |negation, content|
  expect(page.has_text? content).to be == !negation
end

Then /^I should not see ([^"].*[^:])$/ do |element|
  expect(page).not_to have_selector selector_for(element)
end

Then /^I should (not )?see a time entry for:$/ do |negation, table|
  step "I should #{negation}see the following time entry:", table
end

Then /^I should (not )?see the following (?:(form fields)|(.+)):$/ do |negation, form_fields, model, table|
  if form_fields
    table.rows_hash.each do |field, value|
      expect(page.has_field? field, with: value).to be == !negation
    end
  elsif model
    model = normalize model
    within ".#{model}" do
      table.rows_hash.each do |field, value|
        expect(page.has_selector? ".#{remove_spaces field.downcase}", text: value).to be == !negation
      end
    end
  else
    raise ArgumentError, 'Either "form fields" or a model name is required.'
  end
end

Then "I should see today's date" do
  expect(page).to have_content Time.now.strftime(Date::DATE_FORMATS[:db])
end