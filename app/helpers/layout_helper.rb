module LayoutHelper

  def body_class
    "#{controller.controller_name} #{controller.action_name}"
  end

end
