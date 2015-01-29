Feature: User registration
  As an unregistered user
  I can register as a user
  So I can use the system

  Scenario Outline:
    Given I am not logged in
    And no users exist
    When I go to the user registration page
    And I fill in the following:
      | Email                 | <email>    |
      | Password              | <password> |
      | Password confirmation | <password> |
    And I click "Sign up" within the signup form
    Then I should be on the root page
    And I should see "You have signed up successfully"

    Examples:
      | email            | password |
      | joe.user@aol.com | påssw0rð |
