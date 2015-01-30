Feature: Create and view time entries
  As a User
  I can create and view time entries
  So I have a record of my billable time

Background:
  Given I am logged in

Scenario Outline: Create and view time entries
  Given I have no time entries
  And I am on the time entries page
  When I click "New time entry"
  And I fill in the following:
    | Date        | <date>        |
    | Description | <description> |
    | Hours       | <hours>       |
    | Notes       | <notes>       |
  And I click "Save"
  Then I should be on the time entries page
  And I should see a time entry for:
    | Date        | <date>        |
    | Description | <description> |
    | Hours       | <hours>       |
    | Notes       | <notes>       |

  Examples:
    | description          | hours | date       | notes                   |
    | Duckbill development | 1.5   | 2020-01-21 | This is a sample entry. |

Scenario Outline: Can't see other users' time entries
  Given a user exists with email: "<other_user>"
  And the following time entry exists:
    | User        | <other_user>        |
    | Description | <other_description> |
  When I go to the time entries page
  Then I should not see "<other_description>"

  Examples:
    | other_user       | other_description    |
    | someone@else.org | Someone else's entry |

Scenario: Navigation bar link
  When I click "Time Entries" within the navigation bar
  Then I should be on the time entries page
