Feature: Create time entries
  As a User
  I can create time entries
  So I have a record of my billable time

Scenario Outline: Create time entries
  Given I am logged in
  And I have no time entries
  And I am on the work log page
  When I click "New time entry"
  And I fill in the following:
    | Date        | <date>        |
    | Description | <description> |
    | Hours       | <hours>       |
    | Notes       | <notes>       |
  And I click "Save"
  Then I should be on the work log page
  And I should see a time entry for:
    | Date        | <date>        |
    | Description | <description> |
    | Hours       | <hours>       |
    | Notes       | <notes>       |

  Examples:
    | description          | hours | date       | notes                   |
    | Duckbill development | 1.5   | 2020-01-21 | This is a sample entry. |