Feature: Search fitting brand
  In order to find my shoe size
  As a visitor
  I want search my shoe size by brand

  
Scenario: The visitor saves its searched brand
  Given I am searching for "Nike"    
  Then I should see "Trage jetzt die Schuhe ein, die dir gut passen"

  Scenario: The visitor proceeds to the result page
    Given I am searching for "Nike"    
    And I have a "Adidas" "Superstar" in "46"
    And I have a "Adidas" "Samba" in "45"
    When I follow "meine Größe anzeigen"
    Then I should see "Deine Größe"
    And I should see "Nike" 



