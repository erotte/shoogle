source :rubygems

gem 'bundler', '~> 1.0.15'                                                      

# Edge Rails 3.1:
gem 'rails', :git => "git://github.com/rails/rails.git", :branch => "3-1-stable" 
# ToDo: Switch app to couchrest and couchrest_model 
# gem 'couch_potato', :git => 'https://github.com/langalex/couch_potato.git'
gem 'couchrest_model', :git  => 'git://github.com/couchrest/couchrest_model.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', :branch => "3-1-stable"       
  gem 'coffee-rails', :branch => "3-1-stable"       
  gem 'uglifier'
end

# Basic Extensions
gem 'tzinfo'
gem "devise", :git  => "git://github.com/plataformatec/devise.git"
gem "will_paginate" # may be replaced by kaminari
gem "email_veracity"
gem 'settingslogic'
#gem 'responders'
gem 'decent_exposure'

# Frontend Stuff
gem 'haml-rails'
gem 'jquery-rails'
gem 'compass'
gem 'compass-colors'
gem 'simple_form'
gem 'rails-backbone'

# falls ruby >= 1.9.2 => raus damit!
gem "fastercsv", :require => false
                     
# Deployment
group :rake do
  gem 'vlad'
  gem 'vlad-git'
  gem 'vlad-extras'
end

group :development do
  gem 'unicorn'
  gem 'pry'
  gem 'pry-doc'
end

group :test, :development do
  gem 'factory_girl_rails' #, :require => nil  
  gem 'faker', :git => 'git://github.com/kuehnert/faker.git'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'rspec'
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'fuubar'
  gem 'fuubar-cucumber'    
  gem 'spork'
  gem 'factory_girl_rails'
  gem 'infinity_test'
  gem 'launchy'
  gem 'syntax'
  gem 'database_cleaner'
  gem 'capybara'
  #gem "capybara-webkit"
  gem "pickle", :git => "git://github.com/ianwhite/pickle.git"
  gem 'email_spec'
end


