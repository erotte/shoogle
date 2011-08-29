module FeetHelper

  def searched_shoe_form_options
    {
      #  :update => 'panel',
      #:complete => "
      #              $('#add_shoe_form').show();
      #              $('#losjetzt_eingeben').show('drop', { direction: 'up' });
      #              $('#search_shoes_submit').val('Ändern');
      #              $('#foot_fields input.manufacturer').focus();
      #              init_shoe_completer()
      #             ",
      #:html => { :class => "foot_shoes_form", :id => "searched_shoe_form" },
      #:method => :create,
      #:url => feet_path,
      :remote => true
    }
  end

  def delete_seached_shoe_button opts={}
    link_to image_tag('app/icons_small/cross.png' ),
                   {
                    :url => foot_searched_shoe_path(foot),
                    :method => :delete, :update => 'panel',
                    :before => '$(this).parent("li").slideUp()',
                    :complete => "
                      $('#searched_shoe_form').shoe_completer();
                      $('#step-1').show('drop', { direction: 'up', duration: 1200 });
                      $('#searched_shoe_form input.manufacturer').focus();
                    ",
                    :html => {:title  => "löschen", :class => 'delete', :rel => 'tipsy'},
                    :remote => true
                   }.merge(opts)
     end

  def edit_seached_shoe_button opts={}
    link_to image_tag('app/icons_small/edit.png'),
                    {
                      :url => edit_foot_searched_shoe_path(@foot),
                      :method => :get,
                      :update => 'searched_shoe',
                      :complete => "
                        $('#searched_shoe_form').shoe_completer();
                        $('#searched_shoe_form input.manufacturer').focus();
                      ",
                      :html => {:title => "bearbeiten", :rel => 'tipsy', :class => 'edit'},
                      :remote => true
                    }.merge(opts)
  end

  def delete_shoe_button counter
    link_to image_tag('app/icons_small/cross.png'),
                   :url => "/feet/#{foot.id}/shoes/#{counter}",
                   :method => :delete, :update => 'shoes_list_wrap',
                   :before => '$(this).parent("li").slideUp()',
                   :html => {:class => 'delete', :title => 'Schuh löschen', :rel => 'tipsy'},
                   :remote => true
  end

  def add_shoes_options
    {
      :update => 'shoe_area',
      :complete => "
                    $('#foot_fields input.manufacturer').focus();
                    $('#foot_fields').shoe_completer();
                   ",
      :html => {:class => 'foot_shoes_form', :id => 'foot_fields'},
      :remote => true
    }
  end

end
