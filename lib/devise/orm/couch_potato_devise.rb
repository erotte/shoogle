module Devise
  module Orm
    module CouchPotatoDevise
      module Hook
        def devise_modules_hook!
          extend Schema
          yield
          return unless Devise.apply_schema
          devise_modules.each { |m| send(m) if respond_to?(m, true) }
        end
      end

      #module InstanceMethods
        #def save(options={})
          #if options == false
            #CouchPotato.database.save_document! self
          #else
            #puts self.inspect
            #CouchPotato.database.save_document  self
          #end
        #end
      #end

      #def self.included_modules_hook(klass)
        #klass.send :extend,  self
        #klass.send :include, InstanceMethods
        #yield

        #klass.devise_modules.each do |mod|
          #klass.send(mod) if klass.respond_to?(mod)
        #end
      #end

      def find(*args)
        puts "=\n= CouchPotatoDevise find called \n= args:'#{args.inspect}'\n="
        case args.first
        when :first, :all
          send(args.shift, *args)
        else
          super
        end
      end

      module Schema
        include Devise::Schema

        # Tell how to apply schema methods
        def apply_devise_schema(name, type, options={})
          type = Time if type == DateTime
          type = Fixnum if type == Integer
          property name, { :type => type }.merge(options)
        end
      end

    end
  end
end

CouchPotato::Persistence.extend Devise::Models
