Feature: Search fitting brand
  In order to find my shoe size
  As a visitor
  I want search my shoe size by brand

  
Scenario: The visitor saves its searched brand
  Given I am searching for "Nike"    
  And I press "Weiter"
  Then I should see "Bitte gib ein paar Schuhe ein"

  Scenario: The visitor proceeds to the result page
    Given I am searching for "Nike"    
    And I have a "Adidas" "Superstar" in "46"
    And I have a "Adidas" "Samba" in "45"
    When I follow "Ergebnis Anzeigen"
    Then I should see "Dir passt die Marke" 
    And I should see "Nike" 
    And I should see "in der Größe"



