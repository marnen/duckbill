Feature: Use snapshots in invoice
  As the system
  I take version snapshots of client, project, and user records as they appear on any given invoice
  So that every invoice can later be recreated exactly as it was first printed

Scenario Outline: Client and project snapshots on invoice
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

Scenario Outline: Project snapshot on invoice list
  Given I am logged in
  And I have the following projects:
    | name          |
    | <old_project> |
  And I have an invoice for the project
  When I change the project's name to "<new_project>"
  And I go to the invoices page
  Then I should see "<old_project>"
  But I should not see "<new_project>"

  Examples:
    | old_project     | new_project |
    | Roadrunner Trap | RTX-5000    |

Scenario Outline: User snapshot
  Given I am logged in as the following user:
    | name | <old_name> |
  And I have an invoice
  When I change my name to "<new name>"
  And I go to the invoice's page
  Then I should see "<old_name>" within the invoice sender
  But I should not see "<new_name>" within the invoice sender

  Examples:
    | old_name        | new_name    |
    | Bernie Schwartz | Tony Curtis |
