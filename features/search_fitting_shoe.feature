Feature: Searching for a fitting shoe
  In order find a fitting shoe
  As a visitor
  I want to search a shoe of a given model

  Scenario: New visitor sees only the search form
    Given I am on the homepage
    Then I should not see "Trage jetzt die Schuhe ein, die dir gut passen"

  Scenario: New visitor saves its searched shoe 
    Given I am searching a "Nike" "Air Force 1"    
    Then I should see "Trage jetzt die Schuhe ein, die dir gut passen"

  Scenario: The visitor saves a shoe
    Given I am searching a "Nike" "Air Force 1"
    And I enter shoe "Adidas" "Superstar" in "46"
    When I press "shoe_submit"
    Then I should see "Adidas"
    And I should see "46.0"

  Scenario: The visitor proceeds to the result page
    Given I am searching a "Nike" "Air Force 1"
    And I have a "Adidas" "Superstar" in "46"
    And I have a "Adidas" "Samba" in "45"
    When I follow "meine Größe anzeigen"
    Then I should see "Deine Größe"
    Then I should see "für den Schuh"
    And I should see "Nike"
    And I should see "Air Force 1"

  Scenario: The visitor saves shoes with comma separator
    Given I am searching a "Nike" "Air Force 1"
    And I have a "Puma" "Handball" in "11,5"
    Then I should see "11.5"

  Scenario: The visitor saves shoes with fractions
    Given I am searching a "Nike" "Air Force 1"
    And I have a "Adidas" "Samba" in "44 2/3"
    Then I should see "44 2/3"
    And I should see "44.67"


