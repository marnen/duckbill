Feature: Show projects
  As a user
  I can see a detail page for each project
  So I can review its information without having to edit it

Background:
  Given I am logged in
  And I have a project
  And I am on the project's page

Scenario: Project detail page
  Then I should see the project's name
  And I should see the project's client's name
