require File.expand_path(File.dirname(__FILE__) + '/../import/affilinet.rb')
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment.rb')

namespace :import do
  
  desc "run affilinet import"
  task :affilinet do
    Affilinet.new.import
  end
end