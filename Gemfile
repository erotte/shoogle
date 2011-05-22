source :rubygems
# gem "rails", "3.0.7" # we don't want to load activerecord so we can't require rails (install rails manually)
# Rails stuff without AR
gem 'railties'
gem 'actionpack'
gem 'actionmailer'
gem 'activemodel'
gem 'couch_potato'

# Basic Extensions
gem "validatable"
gem 'devise'
gem "will_paginate" # may be replaced by kaminari
gem "email_veracity"
# gem 'settingslogic'

# falls ruby >= 1.9.2 => raus damit!
gem "fastercsv", :require => false

# Frontend Stuff
gem 'haml-rails'
gem 'jquery-rails'
gem 'compass'
gem 'compass-colors'

# Deployment
gem 'vlad'
gem 'vlad-git'
gem 'vlad-extras'

group :development do
  gem 'unicorn'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem 'fuubar'
  gem 'fuubar-cucumber'    
  gem 'spork'
  gem 'infinity_test'
  gem 'launchy'
  gem 'syntax'
  gem 'database_cleaner'
  gem 'capybara'
  gem "pickle", :git => "git://github.com/ianwhite/pickle.git"
  gem 'email_spec'
end


