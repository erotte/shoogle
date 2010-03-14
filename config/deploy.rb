#
 # General configuration
 #
 set :application,           'shoogle'
 set :user,                  'shooser'
 set :domain,                "#{user}@83.169.4.130"
 set :revision,              'master'
 set :repository,            'git@github.com:erotte/shoogle.git'
 set :deploy_to,             '/home/shooser/webapp/alpha'
 set :web_command,           'nginx'
 set :deploy_via,            :copy
 set :git_shallow_clone,     1

 namespace :vlad do
   set :app_command, "/etc/init.d/nginx"
  
 
   desc "Pull from git, run migrations, then (re)start the app server"
   task :migrate_deploy => [:update, :migrate, :start_app, :cleanup ]
 
   desc "Pull from git then (re)start the app server"
   task :deploy => [:update, :start_app, :cleanup]
 
   desc 'Restart Passenger'
   remote_task :restart do
     puts "Touching: #{deploy_to}current/tmp/restart.txt"
     run "touch #{deploy_to}/current/tmp/restart.txt"
   end
   
   desc 'Restarts the nginx servers'
   remote_task :start_web, :roles => :app do
     run "sudo #{app_command} restart"
   end
 end