# Capfile adapted from:
# http://kris.me.uk/2011/10/28/rails-rvm-passenger-capistrano-git-apache.html

# RVM bootstrap
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2-p290'

# bundler bootstrap
require "bundler/capistrano"

# main details
set :application, "wishlist"
server "mhyee.com", :app, :web, :db, :primary => true

#server details
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
end
