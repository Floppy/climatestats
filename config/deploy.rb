require "bundler/capistrano"
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.3'

set :application, "climatestats"

set :repository,  "https://github.com/Floppy/climatestats.git"
set :branch, 'CURRENT'
set :git_shallow_clone, 1
set :deploy_to, "/var/www/#{application}"

set :user, 'deploy'
ssh_options[:forward_agent] = true
set :use_sudo, false

role :web, "176.58.121.71"                          # Your HTTP server, Apache/etc
role :app, "176.58.121.71"                          # This may be the same as your `Web` server
role :db,  "176.58.121.71", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:update_code","deploy:config_symlink"

namespace :deploy do
  task :config_symlink do
    run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end