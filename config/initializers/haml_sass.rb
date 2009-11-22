# Init HAML
Haml.init_rails(binding)

# Configure Haml
Haml::Template.options[:format] = :html5
Haml::Template.options[:attr_wrapper] = '"'

