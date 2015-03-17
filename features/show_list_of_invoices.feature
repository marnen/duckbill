Feature: Show list of invoices
  As a user
  I can see a list of invoices
  So I can review the billing I've already done

Scenario Outline:
  Given I am logged in
  And I have the following invoices:
    | project    |
    | <project1> |
    | <project2> |
  When I go to the invoices page
  Then I should see "<project1>"
  And I should see "<project2>"

  Examples:
    | project1        | project2         |
    | Roadrunner Trap | Perpetual Motion |
