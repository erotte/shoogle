Feature: Shoe validation
  In order insert my own shoes
  As a user
  I want helpful error messages if I do something wrong

  Scenario: Inserting a Shoe without size
    Given I am searching a "Nike" "Air Force 1"
    When I fill in "shoe[manufacturer]" with "Adidas"
    And I fill in "shoe[model]" with "Samba"
    And I press "shoe_submit"
    Then I should see "Size can't be empty"


  
  
  
