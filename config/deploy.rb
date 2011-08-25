# If Vlad does not find some commands, try the following:
#
# To enable per user PATH environments for ssh logins you
# need to add to your sshd_config:
# PermitUserEnvironment yes
#
# After that, restart sshd!
#
# Then in your "users" ssh home directory (~/.ssh/environment),
# add something to this effect (your mileage will vary):
# PATH=/opt/ruby-1.8.7/bin:/usr/local/bin:/bin:/usr/bin
#
# For details on that, see:
# http://zerobearing.com/2009/04/27/capistrano-rake-command-not-found
#
# Maybe you also need to configure SSH Agent Forwarding:
#
# $ ssh-add ~/.ssh/<private_keyname>
#
# Edit your ~/.ssh/config file and add something like this:
# Host <name>
#   HostName <ip or host>
#   User <username>
#   IdentityFile ~/.ssh/<filename>
#   ForwardAgent yes
#
#  IMPORTANT: The Host alias name must be the same as in :domain 
# For details on that, see:
# http://jordanelver.co.uk/articles/2008/07/10/rails-deployment-with-git-vlad-and-ssh-agent-forwarding/


set :user, "deploy"
set :application, "shoogle"
set :domain, "178.77.76.127"
set :deploy_to, "/var/www/#{application}"
set :repository, "git@github.com:erotte/#{application}.git"
# Revision defaults to master
set :revision, "origin/rails3.1"
set :bundle_cmd, "/usr/local/rvm/gems/ree-1.8.7-2011.03/bin/bundle"
set :web_command, "/etc/init.d/nginx"
set :symlinks, { 'couchdb.yml' => 'config/couchdb.yml' }
# add shared/bundle to setup
set :shared_paths, shared_paths.merge({'bundle' => '.bundle'})
role :app, domain
role :web, domain
role :db,  domain, :primary => true

require 'bundler/vlad'

namespace :vlad do
  desc "Full deployment cycle: Update, install bundle, migrate, restart, cleanup"
  remote_task :deploy, :roles => :app do
    %w(update symlink bundle:install assets start_app cleanup).each do |task|
      Rake::Task["vlad:#{task}"].invoke
    end
  end


  desc "Compile assets"
  task :assets do
    run "cd #{release_path}; RAILS_ENV=#{rails_env}; #{bundle_cmd} exec rake assets:precompile"
  end
end
