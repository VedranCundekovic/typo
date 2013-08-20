Feature: Merge Articles Additional Scenarios
  As a blog administrator
  In order to organize information on some subject
  I want to be able to merge articles

  Background:
    Given the blog is set up
    And the following users exist:
      | login | password | name | admin |
      | tony  | 654321   | Tony | true  |
      | john  | 123456   | John | false |
    And the following articles exist:
      | title       | body                  | author |
      | Admin rulez | Admins are uber cool! | tony   |
      | Admin sux   | Admins are evil!      | john   |

  Scenario: The merge interface should not be presented to non-administrators
    Given I am logged in as non-admin "john"
    And I am on the edit page for "Admin sux" article
    Then I should not see "Merge Articles"
    And I should not see "Merge With This Article" button

  Scenario: The merge interface should be presented to administrators
    Given I am logged in as admin "tony"
    And I am on the edit page for "Admin sux" article
    Then I should see "Merge Articles"
    And I should see "Merge With This Article" button
