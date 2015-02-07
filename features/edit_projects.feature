Feature: Edit projects
  As a user
  I can edit my projects
  So I can maintain an accurate list of projects

  Scenario Outline: Edit projects
    Given I am logged in as "<user>"
    And the following client exists:
      | user   | name     |
      | <user> | <client> |
    And the following project exists:
      | client   | name       |
      | <client> | <old_name> |
    And I am on the projects page
    When I click "edit"
    And I fill in the following:
      | Name | <new_name> |
    And I click "Save"
    Then I should be on the projects page
    And I should see "Your project was successfully updated."
    And I should see the following project:
      | Name | <new_name> |
    But I should not see the following project:
      | Name | <old_name> |

    Examples:
      | user        | client     | old_name | new_name             |
      | joe@aol.com | Acme Corp. | H-Bomb   | Thermonuclear Device |

  Scenario Outline: Can't edit projects for other users' clients
    Given I am logged in as "jsmith@gmail.com"
    And a user exists with email: "<other_user>"
    And the following client exists:
      | user         | name     |
      | <other_user> | <client> |
    And the following project exists:
      | client   |
      | <client> |
    Then I should not be allowed to go to the project's edit page

    Examples:
      | other_user             | client      |
      | someone_else@yahoo.com | FooBar Inc. |
