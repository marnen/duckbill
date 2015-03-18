When "I click on the project's client's name" do
  click_on @project.client.name
end

Then "I should see the project's name" do
  expect(page).to have_text @project.name
end

Then "I should see the project's client's name" do
  expect(page).to have_text @project.client.name
end