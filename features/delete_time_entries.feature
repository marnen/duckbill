Feature: Delete time entries
  As a user
  I can delete my time entries
  So I can get rid of mistakes

Scenario:
  Given I am logged in
  And I have 1 time entry
  And I am on the time entries page
  When I click "delete"
  Then I should be on the time entries page
  And I should see "Your time entry was successfully deleted."
  And I should not see any time entries
