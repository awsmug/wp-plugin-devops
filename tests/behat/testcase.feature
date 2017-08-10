Feature: Searching Google
  We are visiting the google and searching for behat

  Scenario: Visiting
    Given I am on Google
    When I search for "behat"
    Then The first heading should contain "Behat"