Feature: Generate invoices
  As a user
  I can generate invoices from the time entries I've created
  So I can bill clients

Scenario Outline: Generate an invoice
  Given I am logged in as the following user:
    | time zone | Eastern Time (US & Canada) |
  And I have the following client:
    | name     |
    | <client> |
  And I have the following projects:
    | client   | name        |
    | <client> | <project_1> |
    | <client> | <project_2> |
  And I have the following time entries:
    | project     | description         |
    | <project_1> | <description_1>     |
    | <project_1> | <description_2>     |
    | <project_2> | <other_description> |
  And the time is frozen at <date> 23:00 in zone "Eastern Time (US & Canada)"
  When I go to the invoices page
  And I click "New invoice"
  And I select "<project_1>" from "Project"
  And I click "Create"
  Then I should be on an invoice page
  When <pdf_or_not>
  Then I should see the invoice number
  And I should see "<date>" within the invoice date
  And I should see my name
  And I should see my e-mail address
  And I should see my company
  And I should see my street
  And I should see my city
  And I should see my ZIP
  And I should see "<client>"
  And I should see "<project_1>"
  And I should see "<description_1>"
  And I should see "<description_2>"
  But I should not see "<other_description>"

  Examples:
    | client     | project_1 | project_2 | description_1 | description_2 | other_description | pdf_or_not            | date       |
    | Acme Corp. | Alpha     | Beta      | Task One      | Task Two      | Other Task        | I click "View as PDF" | 2015-02-15 |
    | XYZ Inc.   | Psi       | Omega     | Screwdriver   | Hammer        | Blowtorch         | I do nothing          | 2020-03-21 |

Scenario: Navigation link
  Given I am logged in
  And I click "Invoices" within the navigation bar
  Then I should be on the invoices page