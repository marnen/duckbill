Feature: Edit time entries
  As a user
  I can edit my time entries
  So I can maintain an accurate time record

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

  Scenario Outline: Can't edit other users' time entries
    Given I am logged in as "jsmith@gmail.com"
    And a user exists with email: "<other_user>"
    And the following time entry exists:
      | user | <other_user> |
    Then I should not be allowed to go to the time entry's edit page

    Examples:
      | other_user             |
      | someone_else@yahoo.com |