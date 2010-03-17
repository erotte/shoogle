#
# General configuration
#
#
set :application, 'shoogle'
set :user, 'shooser'
set :domain, "#{user}@83.169.4.130"
set :revision, 'master'
set :repository, 'git@github.com:erotte/shoogle.git'
set :deploy_to, '/home/shooser/webapp/alpha'
set :web_command, 'nginx'
set :git_shallow_clone, 1
set :app_command, "/etc/init.d/nginx"

namespace :vlad do

  desc "Pull from git then (re)start the app server"
  remote_task :deploy => [:git_update, :create_symlinks, :restart]

  desc 'Restart Passenger Rails'
  remote_task :restart do
    puts "Touching: #{deploy_to}≤/tmp/restart.txt"
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  desc 'Update Repo'
  remote_task :git_update do
    run [ "cd #{scm_path}/repo",
          "#{git_cmd} pull",
          "#{git_cmd} submodule init",
          "#{git_cmd} submodule update"
        ].join(" && ")
  end

  desc "Updates the symlinks for shared paths"
  remote_task :create_symlinks, :roles => :app do
    repo_path = "#{scm_path}/repo" 
    run [ "rm -fr #{repo_path}/log && ln -s #{shared_path}/log #{repo_path}/log",
          "rm -fr #{repo_path}/public/system && ln -s #{shared_path}/system #{repo_path}/public/system",
          "rm -fr #{repo_path}/tmp/pids && ln -s #{shared_path}/pids #{repo_path}/tmp/pids" ].join(" && ")
    run "rm -f #{current_path} && ln -s #{repo_path} #{current_path}"
  end

  desc "Vlad Variablen anzeigen"
  remote_task :vars do
    puts "git_cmd:	        #{git_cmd}"
    puts "repository:	        #{repository}"
    puts "deploy_to:	        #{deploy_to}"
    puts "domain:	            #{domain}"
    puts "current_path:	    #{current_path}"
    puts "current_release:	#{current_release}"
    puts "deploy_timestamped:	#{deploy_timestamped}"
    puts "deploy_via:	        #{deploy_via}"
    puts "latest_release:	    #{latest_release}"
    puts "migrate_args:	    #{migrate_args}"
    puts "migrate_target:	    #{migrate_target}"
    puts "rails_env:	        #{rails_env}"
    puts "rake_cmd:	        #{rake_cmd}"
    puts "release_name:	    #{release_name}"
    puts "release_path:	    #{release_path}"
    puts "releases:	        #{releases}"
    puts "releases_path:	    #{releases_path}"
    puts "revision:	        #{revision}"
    puts "rsync_cmd:	        #{rsync_cmd}"
    puts "rsync_flags:	    #{rsync_flags}"
    puts "scm_path:	        #{scm_path}"
    puts "shared_path:	    #{shared_path}"
    puts "ssh_cmd:	        #{ssh_cmd}"
    puts "ssh_flags:	        #{ssh_flags}"
    puts "sudo_cmd:	        #{sudo_cmd}"
    puts "sudo_flags:	        #{sudo_flags}"
    puts "sudo_prompt:	    #{sudo_prompt}"
    puts "sudo_password:	    #{sudo_password}"
    puts "umask:              #{umask}"
  end
  
  desc 'Restarts the nginx servers'
  remote_task :restart_server, :roles => :app do
    run "sudo #{app_command} stop"
    sleep(2)
    run "sudo #{app_command} start"
    puts "NginX gestartet."
  end

end