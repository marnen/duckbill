Feature: Manage time entries
  As a User
  I can manage time entries
  So I have a record of my billable time

Background:

Scenario Outline: Create and view time entries
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

Scenario Outline: Edit time entries
  Given I am logged in as "<user>"
  And the following time entry exists:
    | user        | <user>            |
    | date        | <old_date>        |
    | description | <old_description> |
    | hours       | <old_hours>       |
    | notes       | <old_notes>       |
  And I am on the work log page
  When I click "edit"
  And I fill in the following:
    | Date        | <new_date>        |
    | Description | <new_description> |
    | Hours       | <new_hours>       |
    | Notes       | <new_notes>       |
  And I click "Save"
  Then I should be on the work log page
  And I should see a time entry for:
    | Date        | <new_date>        |
    | Description | <new_description> |
    | Hours       | <new_hours>       |
    | Notes       | <new_notes>       |
  But I should not see a time entry for:
    | Date        | <old_date>        |
    | Description | <old_description> |
    | Hours       | <old_hours>       |
    | Notes       | <old_notes>       |

    Examples:
      | user        | old_date   | new_date   | old_description | new_description | old_hours | new_hours | old_notes  | new_notes  |
      | joe@aol.com | 2020-01-21 | 2021-02-22 | Old description | New description | 1         | 2         | Old notes. | New notes. |

Scenario Outline: Can't see other users' time entries
  Given a user exists with email: "<other_user>"
  And the following time entry exists:
    | User        | <other_user>        |
    | Description | <other_description> |
  And I am logged in
  When I go to the work log page
  Then I should not see "<other_description>"

  Examples:
    | other_user       | other_description    |
    | someone@else.org | Someone else's entry |
