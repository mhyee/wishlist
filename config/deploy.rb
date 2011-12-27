# Capfile adapted from:
# http://kris.me.uk/2011/10/28/rails-rvm-passenger-capistrano-git-apache.html

# bundler bootstrap
require "bundler/capistrano"
set :default_environment, {
  'PATH' => "/usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH"
}

# main details
set :application, "wishlist"
server "mhyee.com", :app, :web, :db, :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:keys] = File.join(ENV["HOME"], ".ssh", "app@mhyee.com")
set :deploy_to, "/var/www/wishlist.mhyee.com"
set :deploy_via, :remote_cache
set :user, "app"
set :use_sudo, false

# repo details
set :scm, :git
set :repository, "git@git.mhyee.com:wishlist.git"
set :scm_username, "app"
set :branch, "master"

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Restart application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Uploads and symlinks sensitive configuration files"
  task :secrets do
    ['database.yml', 'secrets.yml'].each do |file|
      transfer :up, "#{File.dirname(__FILE__)}/#{file}", "#{shared_path}/#{file}"
      run "ln -sf #{shared_path}/#{file} #{current_release}/config/#{file}"
    end
  end
end

before "deploy:update_code", "deploy:secrets"
before "deploy:assets:precompile", "bundle:install"