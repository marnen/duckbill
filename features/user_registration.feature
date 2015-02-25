Feature: User registration
  As an unregistered user
  I can register as a user
  So I can use the system

Scenario Outline:
  Given I am not logged in
  And no users exist
  When I go to the user registration page
  And I fill in the following:
    | E-mail address        | <email>       |
    | Password              | <password>    |
    | Password confirmation | <password>    |
    | Name                  | <name>        |
    | Company               | <company>     |
    | Street                | <street>      |
    | City                  | <city>        |
    | State                 | <state>       |
    | ZIP code              | <zip>         |
    | Time zone             | <time_zone>   |
    | Date format           | <date_format> |
  And I click "Sign up" within the signup form
  Then I should be on the root page
  And I should see "You have signed up successfully"

  Examples:
    | email            | password | name     | street          | city    | state | zip   | time_zone | date_format |
    | joe.user@aol.com | påssw0rð | Joe User | 123 Main Street | Anytown | NY    | 12345 | Eastern   | 15 Feb 2010 |
