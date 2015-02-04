Feature: Generate invoices
  As a user
  I can generate invoices from the time entries I've created
  So I can bill clients

Scenario Outline:
  Given I am logged in
  And I have the following client:
    | name | <client> |
  And I have the following projects:
    | client   | name        |
    | <client> | <project_1> |
    | <client> | <project_2> |
  And I have the following time entries:
    | project     | description         |
    | <project_1> | <description_1>     |
    | <project_1> | <description_2>     |
    | <project_2> | <other_description> |
  When I go to the invoices page
  And I click "New invoice"
  And I select "<project_1>" from "Project"
  And I click "Create"
  Then I should be on an invoice page
  And I should see "<client>"
  And I should see "<project_1>"
  And I should see "<description_1>"
  And I should see "<description_2>"
  But I should not see "<other_description>"

  Examples:
    | client     | project_1 | project_2 | description_1 | description_2 | other_description |
    | Acme Corp. | Alpha     | Beta      | Task One      | Task Two      | Other Task        |
