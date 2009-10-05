module FeetHelper
  def remove_shoe_button(text) 
    link_to_function "<span>-</span>", 
    "remove_shoe_fields(this)", :title => text, :class => "remove_shoe" 
  end

  def remove_button_unless_new_record(fields)
    out = ''
    out << fields.hidden_field(:_delete)  unless fields.object.new_record?
    out << remove_shoe_button("Zeile löschen")
    out
  end
  
  def add_shoe_button
    link_to_function image_tag('app/add.gif', :alt => " + "), "add_shoe_fields(this)", :id => 'add_shoe_fields'
  end
  
  # Kopiert aus http://github.com/alloy/complex-form-examples/
  # 
  # This method demonstrates the use of the :child_index option to render a
  # form partial for, for instance, client side addition of new nested
  # records.
  #
  # This specific example creates a link which uses javascript to add a new
  # form partial to the DOM.
  #
  #   <% form_for @project do |project_form| -%>
  #     <div id="tasks">
  #       <% project_form.fields_for :tasks do |task_form| %>
  #         <%= render :partial => 'task', :locals => { :f => task_form } %>
  #       <% end %>
  #     </div>
  #   <% end -%>
  def generate_html(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||="#{method.to_s.singularize}.haml"
    options[:form_builder_local] ||= :f  

    form_builder.fields_for(method, options[:object], :child_index => 'NEW_RECORD') do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end

  def generate_template(form_builder, method, options = {})
    escape_javascript generate_html(form_builder, method, options)
  end
  
end
