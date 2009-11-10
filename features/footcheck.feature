Feature: Footcheck
  In order to test the credibility of a user input
  As a admin
  I want to get a forecast every shoe of a foot

  Scenario: Check of an old foot
    Given a foot with
      | Nike         | Air Force 1 | 46 |
      | Adidas       | Samba       | 45 |
    When I am on listing feet page
    And I follow "foot_check"
    Then I should see "Air Force 1"
    And I should see "45.5"
  
  
  
