# -*- encoding : utf-8 -*-
# require 'capistrano/ext/multistage'
# require 'bundler/capistrano' #Using bundler with Capistrano
# require "whenever/capistrano"
# require 'cape'
# require "capistrano-rbenv"

lock '3.11.2'
set :application, "applebeauty"
set :repo_url,  "git@github.com:Unayung/applebeauty.git"
set :conditionally_migrate, true
set :rbenv_map_bins, %w{rake gem bundle ruby rails whenever}
set :rbenv_type, :user
set :rbenv_ruby, "2.3.1"
# Cape do
#   # Create Capistrano recipes for all Rake tasks.
#   mirror_rake_tasks :link
# end
set :format , :pretty
set :log_level, :info
set :bundle_path, -> { shared_path.join('vendor/bundle') }
# Default value for :pty is false
set :pty, true
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/config.yml', 'config/schedule.rb')
# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# set :stages, %w(staging production)
# set :default_stage, "production"

# # default_environment["RAILS_ENV"] = "production"

# set :application, "applebeauty"
# set :repo_url,  "git@github.com:Unayung/applebeauty.git"
# set :scm, :git
# set :user, "apps"
# set :runner, "apps"
# set :deploy_via, :remote_cache
# set :git_shallow_clone, 1
# set :use_sudo, false
# set :whenever_command, "bundle exec whenever"
# set :bundle_flags, "--path #{shared_path}/bundle --quiet"
# namespace :my_tasks do
#   task :symlink, :roles => [:web] do
#     run "mkdir -p #{deploy_to}/shared/log"
#     run "mkdir -p #{deploy_to}/shared/pids"

#     symlink_hash = {
#       "#{shared_path}/config/database.yml"   => "#{release_path}/config/database.yml",
#       "#{shared_path}/config/config.yml"    => "#{release_path}/config/config.yml",
#       "#{shared_path}/uploads"              => "#{release_path}/public/uploads",
#       "#{shared_path}/config/schedule.rb"   => "#{release_path}/config/schedule.rb",
#     #  "#{shared_path}/db/sphinx"            => "#{release_path}/db/sphinx"
#     #  "#{shared_path}/config/newrelic.yml"  => "#{release_path}/config/newrelic.yml",
#     #  "#{shared_path}/config/redis.yml"     => "#{release_path}/config/redis.yml",
#     #  "#{shared_path}/config/mailman.yml"     => "#{release_path}/config/mailman.yml",
#     }

#     symlink_hash.each do |source, target|
#       run "ln -sf #{source} #{target}"
#     end
#   end

# end

# set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)

# namespace :deploy do
#   namespace :assets do

#     desc <<-DESC
#       Run the asset precompilation rake task. You can specify the full path \
#       to the rake executable by setting the rake variable. You can also \
#       specify additional environment variables to pass to rake via the \
#       asset_env variable. The defaults are:

#         set :rake,      "rake"
#         set :rails_env, "production"
#         set :asset_env, "RAILS_GROUPS=assets"
#         set :assets_dependencies, fetch(:assets_dependencies) + %w(config/locales/js)
#     DESC
#     task :precompile, :roles => :web, :except => { :no_release => true } do
#       from = source.next_revision(current_revision)
#       if capture("cd #{latest_release} && #{source.local.log(from)} #{assets_dependencies.join ' '} | wc -l").to_i > 0
#         run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
#       else
#         logger.info "Skipping asset pre-compilation because there were no asset changes"
#       end
#     end

#   end
# end

# namespace :sitemap do

#   desc "refresh sitemap"
#   task :refresh do
#     run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake sitemap:refresh"
#   end

#   desc "refresh sitemap without ping"
#   task :refresh_without_ping do
#     run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake -s sitemap:refresh"
#   end

#   desc "copy_old_sitemap"
#   task :copy_old_sitemap do
#       run "if [ -e #{previous_release}/public/sitemap_index.xml.gz ]; then cp #{previous_release}/public/sitemap* #{current_release}/public/; fi"
#   end
# end

# namespace :remote_rake do
#   desc "Run a task on remote servers, ex: cap staging rake:invoke task=cache:clear"
#   task :invoke do
#     run "cd #{deploy_to}/current; RAILS_ENV=#{rails_env} bundle exec rake #{ENV['task']}"
#   end
# end
# namespace :deploy do

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       # Your restart mechanism here, for example:
#       execute :touch, release_path.join('tmp/restart.txt')
#       # execute "wget -O /dev/null #{fetch(:server_name)} 2>/dev/null"
#     end
#   end
# end

# after "deploy:finished", "deploy:restart"
# # after "deploy:finalize_update", "my_tasks:symlink"
# after :deploy, "deploy:cleanup"
# after :deploy, "whenever:update_crontab"
# #after "deploy:restart", "sphinx:rebuild"
# #after "deploy:restart", "sphinx:restart"
