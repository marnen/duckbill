Feature: Invoice navigation link
  As the user
  I can see a link to invoicing in the navbar
  So I can easily create invoices

  Scenario: Navigation link
    Given I am logged in
    And I click "Invoices" within the navigation bar
    Then I should be on the invoices page