Feature: Create and view clients
  As a User
  I can create and view time entries
  So I can keep track of whom I'm working for

Background:
  Given I am logged in

Scenario Outline: Create and view clients
  Given I have no clients
  And I am on the clients page
  When I click "New client"
  And I fill in the following:
    | Name    | <name>    |
    | Company | <company> |
    | E-mail  | <email>   |
    | Street  | <street>  |
    | City    | <city>    |
    | State   | <state>   |
    | ZIP     | <zip>     |
  And I click "Save"
  Then I should be on the clients page
  And I should see the following client:
    | Name    | <name>    |
    | Company | <company> |
    | email   | <email>   |
    | Street  | <street>  |
    | City    | <city>    |
    | State   | <state>   |
    | ZIP     | <zip>     |

  Examples:
    | name       | company   | email           | street          | city    | state | zip   |
    | John Smith | Acme Inc. | jsmith@acme.com | 123 Main Street | Anytown | NY    | 12345 |

Scenario Outline: Can't see other users' clients
  Given a user exists with email: "<other_user>"
  And the following client exists:
    | User | <other_user> |
    | Name | <other_name> |
  When I go to the clients page
  Then I should not see "<other_name>"

  Examples:
    | other_user       | other_name            |
    | someone@else.org | Someone else's client |

Scenario: Navigation bar link
  When I click "Clients" within the navigation bar
  Then I should be on the clients page
