Feature: Format dates on invoices
  As a user
  I can specify the date format used on my invoices
  So I can customize my invoices to my taste

  Scenario Outline:
    Given I am logged in as the following user:
      | password | <password> |
    And the time is frozen at <now>
    And I have the following project:
      | name      |
      | <project> |
    And I have an invoice for the project with the following time entry:
      | date   |
      | <date> |
    And I am on the user profile edit page
    When I fill in the following:
      | Date format      | <date_format> |
      | Current password | <password>    |
    And I click "Save"
    And I go to the invoice's page
    Then I should see "<now_formatted>" within the invoice date
    And I should see "<date_formatted>"

    Examples:
      | password | date_format | now        | now_formatted | date       | date_formatted |
      | passw0rd | 2010-02-15  | 2015-06-21 | 2015-06-21    | 1974-10-10 | 1974-10-10     |
      | passw0rd | 15 Feb 2010 | 2020-08-01 | 01 Aug 2020   | 1776-07-04 | 04 Jul 1776    |
