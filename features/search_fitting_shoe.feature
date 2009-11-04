Feature: Searching for a fitting shoe
  In order find a fitting shoe
  As a visitor
  I want to search a shoe of a given model

  Scenario: New visitor sees only the search form
    Given I am on the homepage
    Then I should not see "Bitte gib ein paar Schuhe ein, die gut passen:"

  Scenario: New visitor saves its requested shoe
    Given I am on the homepage
    When I fill in "manufacturer" with "Nike"
    And I fill in "model" with "Air Force 1"
    And I press "search_shoes_submit"
    Then I should see "Bitte gib ein paar Schuhe ein, die gut passen:"




