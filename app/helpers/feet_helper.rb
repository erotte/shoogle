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
  
  def add_shoes_options
    { :update => 'shoe_area',
      :html => {:class => 'foot_shoes_form', :id => 'foot_fields'},
    }
  end

end
