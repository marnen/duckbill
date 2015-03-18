Feature: Show projects
  As a user
  I can see a detail page for each project
  So I can review its information without having to edit it

Scenario Outline:
  Given I am logged in
  And I have the following project:
    | name      | client   |
    | <project> | <client> |
  When I go to the project's page
  Then I should see "<project>"
  And I should see "<client>"

  Examples:
    | project          | client      |
    | Perpetual Motion | Vlad Dracul |
