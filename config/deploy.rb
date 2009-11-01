#
 # General configuration
 #
 set :application,           'shoogle'
 set :user,                  'shooser'
 set :revision,              'master'
 set :web_command,            'nginx'

 namespace :vlad do
   # set :app_command, "/etc/init.d/nginx"
  

   desc "Pull from git, run migrations, then (re)start the app server"
   task :migrate_deploy => [:update, :migrate, :start_app]

   desc "Pull from git then (re)start the app server"
   task :deploy => [:update, :start_app]

   task :alpha do
     set :domain,         "beta.example.com"
     set :deploy_to,      '/home/shooser/webapp/alpha'
     set :domain,                "#{user}@83.169.4.130"
     set :repository,            'git@github.com:erotte/shoogle.git'
   end

   desc 'Restart Passenger'
   remote_task :restart do
     puts "Touching: #{deploy_to}current/tmp/restart.txt"
     run "touch #{deploy_to}/current/tmp/restart.txt"
   end

 end
