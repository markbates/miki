# here is a good standard example
set :application, "miki"
# Change this appropriately depending on what site you are testing
set :domain, "www.mackwiki.com"  # your domain.com for this app
set :user, "markbates" # your username on slicehost

#from http://github.com/guides/deploying-with-capistrano
default_run_options[:pty] = true
set :repository,  "git://github.com/markbates/miki.git" # your repository. this could be anywhere, but i recommend github
set :scm, "git"
set :user, "markbates" #github username
set :branch, "master" #this is the branch you want. most likely master
set :deploy_via, :remote_cache

#from hostingrails.com/forums/wiki_thread/46
set :use_sudo, false
set :port, 22  # your port on slicehost. Standard port for ssh is 22, but if you followed the slicehost articles, you probably changed this to something different
set :deploy_to, "/home/#{user}/#{application}"          # Where on the server your app will be deployed
set :chmod755, "app config tmp log db lib public vendor"  	# Some files that will need proper permissions

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, domain
role :web, domain
role :db,  domain, :primary => true

desc "Reload Nginx"
task :reload_nginx do
  sudo "/etc/init.d/nginx reload"
end

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    # sudo "thin restart -s 3 -e production -c /home/#{user}/#{application}/current/"
    run "cd /home/#{user}/#{application}/current; mackery server restart -e production -C /home/#{user}/#{application}/current/config/thin.yml"
  end
  task :start, :roles => :app do
    run "cd /home/#{user}/#{application}/current; mackery server start -e production -C /home/#{user}/#{application}/current/config/thin.yml"
  end
  task :stop, :roles => :app do
    run "cd /home/#{user}/#{application}/current; mackery server stop -e production -C /home/#{user}/#{application}/current/config/thin.yml"
  end
  
  task :migrate, :roles => :db, :only => { :primary => true } do
    rake = fetch(:rake, "rake")
    mack_env = fetch(:mack_env, "production")
    migrate_target = fetch(:migrate_target, :latest)

    directory = case migrate_target.to_sym
      when :current then current_path
      when :latest  then current_release
      else raise ArgumentError, "unknown migration target #{migrate_target.inspect}"
      end

    run "cd #{directory}; #{rake} db:migrate##{mack_env}"
  end
  
  task :create_production_db, :roles => :db, :only => { :primary => true } do
    rake = fetch(:rake, "rake")
    mack_env = fetch(:mack_env, "production")
    run "cd #{current_path}; #{rake} db:create##{mack_env}"
  end
  
  task :recreate_production_db, :roles => :db, :only => { :primary => true } do
    rake = fetch(:rake, "rake")
    mack_env = fetch(:mack_env, "production")
    run "cd #{current_path}; #{rake} db:recreate##{mack_env}"
  end
end

namespace :gems do
  
  task :install, :roles => :app do
    run "cd #{current_path}"
    run "cd #{current_path}; #{sudo} rake gems:install"
  end
  
end

# after "deploy", "deploy:cleanup"
# after "deploy:cleanup", "reload_nginx"
# after "restart_thin", "reload_nginx"

after "deploy", "reload_nginx"
# after "deploy:update_code", "gems:install"