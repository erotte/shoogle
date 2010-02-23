Feature: Shoe validation
  In order insert my own shoes
  As a user
  I want helpful error messages if I do something wrong

  Scenario: Inserting a Shoe without size
    Given I am searching a "Nike" "Air Force 1"
    When I fill in "foot_shoes_attributes__manufacturer" with "Puma"
    And I fill in "foot_shoes_attributes__model" with "Samba"
    And I press "foot_submit"
    Then I should see "size muss ausgefüllt werden"
    # And I should see "Puma"
    # And I should see "Samba" 
  
  
  
