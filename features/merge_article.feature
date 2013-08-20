Feature: Merge Articles
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

  Scenario: A non-admin cannot merge two articles
    Given I am logged in as non-admin "john"
    And I am on the edit page for "Admin sux" article
    Then I should not see "Merge Articles"
    And I should not see "Merge With This Article" button

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged in as admin "tony"
    When I merge "Admin sux" and "Admin rulez" articles
    Then I should see "Admins are evil!"
    And I should see "Admins are uber cool!"
