Feature: Can't create or view projects for other users' clients
  As a user
  I can't create or view projects for other users' clients
  So that I don't mess up others' billing

Background:
  Given I am logged in

Scenario Outline: Can't create projects for other users' clients
  Given I have the following client:
    | name | <my_client> |
  And a user exists with email: "<other_user>"
  And the following client exists:
    | User | <other_user>   |
    | Name | <other_client> |
  When I go to the new project page
  Then I should see "<my_client>"
  But I should not see "<other_client>"

  Examples:
    | my_client | other_user       | other_client |
    | ABC Corp. | someone@else.org | XYZ Inc.     |

Scenario Outline: Can't view projects for other users' clients
  Given I have the following client:
    | name | <my_client> |
  And a user exists with email: "<other_user>"
  And the following client exists:
    | User | <other_user>   |
    | Name | <other_client> |
  And the following project exists:
    | Client | <other_client>  |
    | Name   | <other_project> |
  When I go to the projects page
  Then I should not see "<other_project>"

  Examples:
    | my_client | other_user       | other_client | other_project               |
    | ABC Corp. | someone@else.org | XYZ Inc.     | Pocket Thermonuclear Device |
