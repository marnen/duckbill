Feature: Create and view projects
  As a user
  I can create projects for each client
  So I can manage billing separately for each project

Background:
  Given I am logged in

Scenario Outline: Create projects
  Given I have the following client:
    | name     |
    | <client> |
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
    | client    | project         |
    | Acme Inc. | Roadrunner Trap |

Scenario: Show message when there are clients but no projects
  Given I have no projects
  And I have 1 client
  When I go to the projects page
  Then I should not see the projects table
  But I should see "You have no projects yet. Why not add some?"
  When I click "add some"
  Then I should be on the new project page

Scenario: Show message when there are no clients
  Given I have no clients
  When I go to the projects page
  Then I should not see the projects table
  But I should see "You have no clients yet. Please add some and then come back here to create your first project."
  When I click "add some"
  Then I should be on the new client page

Scenario: Navigation bar link
  When I click "Projects" within the navigation bar
  Then I should be on the projects page
