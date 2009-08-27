module FeetHelper
  def remove_shoe_button(text) 
    link_to_function "<span>-</span>", 
    "remove_shoe_fields(this)", :title => text, :class => "remove_shoe" 
  end
  
  def add_shoe_button(footform) 
    link_to_function image_tag('app/add.gif', :alt => " + ") do |page| 
      page.insert_html :before, :insert_shoe_button_row, :partial => 'shoe_fields', :locals => {:subform => footform }
    end 
  end
  
  def gender_text(foot) 
    Foot::GENDER.fetch(foot.gender,  "unbekannt") 
  end
end
