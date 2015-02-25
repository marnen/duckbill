Feature: Edit user profile
  As a user
  I can edit my profile
  So I can keep my information up to date

Scenario Outline: Edit user profile
  Given I am logged in as the following user:
    | <field>  | <old_value> |
    | password | påssw0rð    |
  When I go to the user profile edit page
  And I fill in the following:
    | <field>          | <new_value> |
    | Current password | påssw0rð    |
  And I click "Save"
  Then I should see "Your account has been updated successfully."
  When I go to the user profile edit page
  Then I should not see the following form fields:
    | <field> | <old_value> |
  But I should see the following form fields:
    | <field> | <new_value> |

  Examples:
    | field       | old_value       | new_value      |
    | Name        | Bernie Schwartz | Tony Curtis    |
    | Time zone   | Hawaii          | Alaska         |
    | Date format | 2010-02-15      | 15 Feb 2010    |
    | Company     | IBM             | Lenovo         |
    | E-mail      | joe@aol.com     | joe@jsmith.org |
    | Street      | 123 Old Road    | 456 New Street |
    | City        | New York        | Boston         |
    | State       | NY              | MA             |
    | ZIP         | 10001           | 02115          |

Scenario: Navigation link
  Given I am logged in
  When I click "Edit profile" within the navigation bar
  Then I should be on the user profile edit page