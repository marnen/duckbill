Feature: Use snapshots in invoice
  As the system
  I take version snapshots of client, project, and user records as they appear on any given invoice
  So that every invoice can later be recreated exactly as it was first printed

Scenario Outline:
  Given I am logged in
  And I have the following projects:
    | client       | name          |
    | <old_client> | <old_project> |
  And I have an invoice for the project
  When I change the client's name to "<new_client>"
  And I change the project's name to "<new_project>"
  And I go to the invoice's page
  Then I should see "<old_client>"
  And I should see "<old_project>"
  But I should not see "<new_client>"
  And I should not see "<new_project>"

  Examples:
    | old_client | new_client | old_project     | new_project |
    | Acme Inc.  | Acament    | Roadrunner Trap | RTX-5000    |
