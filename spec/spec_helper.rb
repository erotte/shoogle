$:.unshift File.join(File.dirname(__FILE__), '..')
require 'rubygems'
require 'spec'
require 'couch_potato/rspec'
require 'factory'

CouchPotato::Config.database_name = 'couch_potato_test'

#CouchPotato::Config.validation_framework = ENV['VALIDATION_FRAMEWORK'].to_sym unless ENV['VALIDATION_FRAMEWORK'].blank?

# silence deprecation warnings from ActiveModel as the Spec uses Errors#on
begin
  ActiveSupport::Deprecation.silenced = true
rescue
  # ignore errors, ActiveSupport is probably not installed
end

def recreate_db
  CouchPotato.couchrest_database.recreate!
end
#recreate_db

Spec::Matchers.define :string_matching do |regex|
  match do |string|
    string =~ regex
  end
end
