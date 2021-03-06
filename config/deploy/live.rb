set :stage, :live
set :branch, "master"
set :server_name, "unayung.cc"
server 'unayung.cc', user: 'apps', roles: %w{web app db}, primary: true
set :deploy_to, "/home/apps/applebeauty"
set :deploy_user, 'apps'
set :rails_env, :production
# -*- encoding : utf-8 -*-
# require 'capistrano-unicorn'
# set :application, "applebeauty"
# set :domain, "ab.unayung.cc"
# set :repository, "git@github.com:Unayung/applebeauty.git" # your ssh way in github.
# role :app, domain
# role :web, domain
# role :db, domain, :primary => true
# set :deploy_via, :remote_cache
# set :deploy_env, "production"
# set :rails_env, "production"
# set :scm, :git
# set :branch, "master"
# set :scm_verbose, true
# set :use_sudo, false
# set :user, "apps"
# set :group, "apps"

# namespace :deploy do
#   desc "restart"
#   task :restart do
#     run "touch #{current_path}/tmp/restart.txt"
#   end
# end
# desc "Create database.yml and asset packages for production"
# after("deploy:update_code") do
#   db_config = "/home/apps/database.yml.production"
#   run "cp #{db_config} #{release_path}/config/database.yml"
# end
# after "deploy:update_code", "sitemap:copy_old_sitemap"
# after "deploy:update_code", "sitemap:refresh"

# after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded
# after 'deploy:restart', 'unicorn:restart'  # app preloaded