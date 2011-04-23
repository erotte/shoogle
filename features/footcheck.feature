Feature: Footcheck
  In order to test the credibility of a user input
  As a admin
  I want to get a forecast every shoe of a foot

  Scenario: Check of an old foot
    Given I am searching a "Converse" "Chucks"
    And a foot with
      | Nike         | Air Force 1 | 46 |
      | Adidas       | Samba       | 45 |
    When I am on listing feet page
    And I follow "Check"
    Then I should see "Nike"
    And I should see "Adidas"
    And I should see "Durchschnittliche Größe"



