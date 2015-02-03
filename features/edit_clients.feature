Feature: Edit clients
  As a user
  I can edit my clients
  So I can maintain an accurate list of clients

  Scenario Outline: Edit clients
    Given I am logged in as "<user>"
    And the following client exists:
      | user | <user>     |
      | name | <old_name> |
    And I am on the clients page
    When I click "edit"
    And I fill in the following:
      | Name | <new_name> |
    And I click "Save"
    Then I should be on the clients page
    And I should see "Client was successfully updated."
    And I should see the following client:
      | Name | <new_name> |
    But I should not see the following client:
      | Name | <old_name> |

    Examples:
      | user        | old_name   | new_name       |
      | joe@aol.com | John Smith | Johann Schmidt |

  Scenario Outline: Can't edit other users' clients
    Given I am logged in as "jsmith@gmail.com"
    And a user exists with email: "<other_user>"
    And the following client exists:
      | user | <other_user> |
    Then I should not be allowed to go to the client's edit page

    Examples:
      | other_user             |
      | someone_else@yahoo.com |
