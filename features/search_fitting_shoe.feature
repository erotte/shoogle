Feature: Searching for a fitting shoe
  In order find a fitting shoe
  As a visitor
  I want to search a shoe of a given model

  Scenario: New visitor sees only the search form
    Given I am on the homepage
    Then I should not see "Bitte gib ein paar Schuhe ein, die gut passen:"

  Scenario: New visitor saves its searched shoe 
    Given I am on the homepage
    When I fill in "manufacturer" with "Nike"
    And I fill in "model" with "Air Force 1"
    And I press "Weiter"
    Then I should see "Bitte gib ein paar Schuhe ein, die gut passen:"

  Scenario: The visitor saves a shoe
    Given I am on the homepage
    And I am searching a "Nike" "Air Force 1"
    And I enter shoe "Adidas" "Superstar" in "46"
    When I press "Schuhe hinzufügen"
    Then I should see "Adidas"
    And I should see "46.0"

  Scenario: The visitor proceeds to the result page
    Given I am on the homepage
    And I am searching a "Nike" "Air Force 1"
    And I have a "Adidas" "Superstar" in "46"
    And I have a "Adidas" "Samba" in "45"
    When I follow "Ergebnis Anzeigen"
    Then I should see "Dir passt der" 
    And I should see "Air Force 1" 
    And I should see "in der Größe"
    And I should see "45.5"