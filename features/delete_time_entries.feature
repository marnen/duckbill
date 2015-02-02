Feature: Delete time entries
  As a user
  I can delete my time entries
  So I can get rid of mistakes

  Scenario Outline:
    Given I am logged in as "<user>"
    And the following time entry exists:
      | user | <user> |
    And I am on the time entries page
    When I click "delete"
    Then I should be on the time entries page
    And I should not see any time entries

    Examples:
      | user        |
      | joe@aol.com |