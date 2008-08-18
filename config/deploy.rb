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
# set :deploy_via, :remote_cache

#from hostingrails.com/forums/wiki_thread/46
set :use_sudo, false
set :port, 22  # your port on slicehost. Standard port for ssh is 22, but if you followed the slicehost articles, you probably changed this to something different
set :deploy_to, "/home/#{user}/#{application}"          # Where on the server your app will be deployed
set :chmod755, "app config db lib public vendor script script/* public/disp*"  	# Some files that will need proper permissions

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
  sudo "nginx restart"
end

desc "Restart Thin"
task :restart_thin do
  sudo "thin restart -s 3 -e production"
end

# after "deploy", "deploy:cleanup"
# after "deploy:cleanup", "reload_nginx"
# after "reload_nginx", "restart_thin"

after "deploy", "restart_thin"