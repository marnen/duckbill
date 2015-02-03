Feature: Create and view projects
  As a user
  I can create projects for each client
  So I can manage billing separately for each project

  Scenario Outline: Create projects
    Given I am logged in as "<user>"
    And the following client exists:
      | user | <user>   |
      | name | <client> |
    And I am on the projects page
    When I click "New project"
    And I fill in the following:
      | Client | <client> |
      | Name   | <name>   |
    And I click "Save"
    Then I should be on the projects page
    And I should see "Your project was successfully created!"
    And I should see the following project:
      | Client | <client> |
      | Name   | <name>   |

    Examples:
      | user         | client    | project         |
      | joe@user.org | Acme Inc. | Roadrunner Trap |
