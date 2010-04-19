module Devise
  module Orm
    module CouchPotatoDevise
      module InstanceMethods
        def save(options={})
          if options == false
            CouchPotato.database.save_document! self
          else
            CouchPotato.database.save_document  self
          end
        end
      end

      def self.included_modules_hook(klass)
        klass.send :extend,  self
        klass.send :include, InstanceMethods
        yield

        klass.devise_modules.each do |mod|
          klass.send(mod) if klass.respond_to?(mod)
        end
      end
      
      def find(*args)
        puts "=\n=#{args.inspect}\n="
        case args.first
        when :first, :all
          send(args.shift, *args)
        else
          super
        end
      end
      
      include Devise::Schema

      # Tell how to apply schema methods. 
      #
      # This automatically converts 
      # * DateTime to Time
      # * Integer to Fixnum
      def apply_schema(name, type, options={})
        return unless Devise.apply_schema
        type = Time if type == DateTime
        type = Fixnum if type == Integer
        options = {:type => type}.merge(options)
        property name, options
      end
    end
  end
end

CouchPotato::Persistence.extend Devise::Models
