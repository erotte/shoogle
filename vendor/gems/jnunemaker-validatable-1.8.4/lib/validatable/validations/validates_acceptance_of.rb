module Validatable
  class ValidatesAcceptanceOf < ValidationBase #:nodoc:    
    def valid?(instance)
      value = instance.send(self.attribute)
      puts "value #{value}"
      return true if allow_nil && value.nil?
      return true if allow_blank && value.blank?
      puts "%w(1 true t).include?(value): #{%w(1 true t).include?(value)}"
      %w(1 true t).include?(value)
    end
    
    def message(instance)
      super || "must be accepted"
    end
  end
end
