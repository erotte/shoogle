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

  def delete_seached_shoe_button opts={}
    link_to_remote image_tag('app/icons_small/cross.png' ),
                   {
                    :url => foot_searched_shoes_path(@foot),
                    :html => {:title  => "löschen", :class => 'delete', :rel => 'tipsy'},
                    :method => :delete, :update => 'panel'}.merge(opts)
  end

  def edit_seached_shoe_button opts={}
     link_to_remote image_tag('app/icons_small/edit.png' ),
                    {:url => edit_foot_searched_shoes_path(@foot),
                    :method => :get, 
                    :update => 'searched_shoe',
                    :html => {:title => "bearbeiten", :rel => 'tipsy', :class => 'edit'},        
                    :complete => "$('#searched_shoe_form').shoe_completer()"}.merge(opts)  
  end

  def delete_shoe_button counter
    link_to_remote image_tag('app/icons_small/cross.png'),
                   :url => "/feet/#{@foot.id}/shoes/#{counter}",
                   :method => :delete, :update => 'shoes_list',
                   :html => {:class => 'delete', :title => 'Schuh löschen', :rel => 'tipsy'}

  end

  def add_shoes_options
    { :update => 'shoe_area',
      :html => {:class => 'foot_shoes_form', :id => 'foot_fields'},
    }
  end

end
