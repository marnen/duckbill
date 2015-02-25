Feature: Multiple invoices per project
  As a user
  I can have multiple invoices per project
  So I can bill on an ongoing basis

Scenario Outline:
  Given I am logged in
  And I have the following project:
    | name      |
    | <project> |
  And I have an invoice for the project with the following time entry:
    | description |
    | <old_entry> |
  And I have the following time entry:
    | project   | description |
    | <project> | <new_entry> |
  When I go to the new invoice page
  And I select "<project>" from "Project"
  And I click "Create"
  Then I should be on an invoice page
  And I should see "<new_entry>"
  But I should not see "<old_entry>"

  Examples:
    | project          | old_entry | new_entry |
    | Perpetual Motion | Old Entry | New Entry |
