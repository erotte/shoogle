source :rubygems

gem 'bundler', '~> 1.0.15'
# gem "rails", "3.0.9" # we don't want to load activerecord so we can't require rails (install rails manually)
# Rails stuff without AR
gem 'railties',     '3.1.0.rc5'
gem 'actionpack',   '3.1.0.rc5'
gem 'actionmailer', '3.1.0.rc5'
gem 'activemodel',  '3.1.0.rc5'  


gem 'couch_potato'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

# Frontend Stuff
gem 'haml-rails'
gem 'jquery-rails'
gem 'compass'
gem 'compass-colors'

# Basic Extensions
gem 'tzinfo'
gem "validatable"
gem 'devise'
gem "will_paginate" # may be replaced by kaminari
gem "email_veracity"
# gem 'settingslogic'

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
  gem 'infinity_test'
  gem 'launchy'
  gem 'syntax'
  gem 'database_cleaner'
  gem 'capybara'
  gem "pickle", :git => "git://github.com/ianwhite/pickle.git"
  gem 'email_spec'
end


