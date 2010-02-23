module FeetHelper

  def add_shoe_form_attributes
    {:html => {:class => 'foot_shoes_form', :id => 'foot_fields'}, :update => 'shoes_list', :success => 'shoe_add_success(event)'}
  end
end
