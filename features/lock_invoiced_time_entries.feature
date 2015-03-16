Feature: Lock invoiced time entries
  As the system
  I prevent time entries from being changed once they have appeared on an invoice
  So that billing can't get out of sync

Background:
  Given I am logged in
  And I have the following project:
    | name    |
    | Project |
  And I have an invoice for the project with the following time entry:
    | project |
    | Project |

Scenario: Can't edit invoiced time entries
  Then I should not be allowed to go to the time entry's edit page

Scenario: Hide action links for invoiced time entries
  When I go to the time entries page
  Then I should not see "edit"
  And I should not see "delete"