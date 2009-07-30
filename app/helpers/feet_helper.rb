module FeetHelper
  def remove_shoe_button(text) 
    link_to_function image_tag('app/cross.png', :alt => " - "), 
    "$(this).parents('tr').remove()", :title => text 
  end
  
  def add_shoe_button(shoe) 
    link_to_function image_tag('app/add.gif', :alt => " + ") do |page| 
      page.insert_html :before, :insert_shoe_button_row, :partial => 'shoes', :object => shoe
    end 
  end
  
  def gender_text(foot) 
    Foot::GENDER.fetch(foot.gender,  "unbekannt") 
  end
end
