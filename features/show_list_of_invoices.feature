Feature: Show list of invoices
  As a user
  I can see a list of invoices
  So I can review the billing I've already done

Background:
  Given I am logged in

Scenario Outline: List invoices
  Given I have the following invoices:
    | project    |
    | <project1> |
    | <project2> |
  When I go to the invoices page
  Then I should see "<project1>"
  And I should see "<project2>"

  Examples:
    | project1        | project2         |
    | Roadrunner Trap | Perpetual Motion |

Scenario: Show links to invoices
  Given I have an invoice
  And I am on the invoices page
  When I click the invoice number
  Then I should be on the invoice's page

Scenario: Show links to projects
  Given I have an invoice
  And I am on the invoices page
  When I click the invoice's project's name
  Then I should be on the invoice's project's page
