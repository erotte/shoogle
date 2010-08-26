module FeetHelper

  def searched_shoe_form_options
    { :update => 'panel',
      :complete => '
                    $("#add_shoe_form").show();
                    init_shoe_completer();
                    $("#losjetzt_eingeben").show("drop", { direction: "up" }) 
                    $("#search_shoes_submit").val("Ändern")
                    $("#foot_fields input.manufacturer").focus();
                    ',
      :html => {:class => "foot_shoes_form", :id => "searched_shoe_form" }
    }  
  end

  def delete_seached_shoe_button
    link_to_remote image_tag('app/icons_small/cross.png' , :class => 'delete'),
                   :url => foot_searched_shoes_path(@foot),
                   :method => :delete, :update => 'panel'
  end

  def edit_seached_shoe_button
     link_to_remote image_tag('app/icons_small/edit.png' , :class => 'edit'),
                    :url => edit_foot_searched_shoes_path(@foot),
                    :method => :get, 
                    :update => 'searched_shoe',
                    :complete => "$('#searched_shoe_form').shoe_completer()"  
  end
  
  def add_shoes_options
    { :update => 'shoe_area',
      :html => {:class => 'foot_shoes_form', :id => 'foot_fields'},
    }
  end

end
