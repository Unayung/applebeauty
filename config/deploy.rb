# -*- encoding : utf-8 -*-
require 'capistrano/ext/multistage'
require 'bundler/capistrano' #Using bundler with Capistrano
require "rvm/capistrano"   # Load RVM's capistrano plugin.

set :stages, %w(staging production)
set :default_stage, "production" 

default_environment["RAILS_ENV"] = "production"

set :application, "applebeauty"
set :repository,  "git@github.com:Unayung/applebeauty.git"
set :scm, :git
set :user, "apps"
set :runner, "apps"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :use_sudo, false
set :rvm_ruby_string, '1.9.2'
set :whenever_command, "bundle exec whenever"

namespace :my_tasks do
  task :symlink, :roles => [:web] do
    run "mkdir -p #{deploy_to}/shared/log"
    run "mkdir -p #{deploy_to}/shared/pids"
    
    symlink_hash = {
      "#{shared_path}/config/database.yml"   => "#{release_path}/config/database.yml",
      "#{shared_path}/config/config.yml"    => "#{release_path}/config/config.yml",
      "#{shared_path}/uploads"              => "#{release_path}/public/uploads",
      "#{shared_path}/config/schedule.rb"   => "#{release_path}/config/schedule.rb",
    #  "#{shared_path}/db/sphinx"            => "#{release_path}/db/sphinx"
    #  "#{shared_path}/config/newrelic.yml"  => "#{release_path}/config/newrelic.yml",
    #  "#{shared_path}/config/redis.yml"     => "#{release_path}/config/redis.yml",
    #  "#{shared_path}/config/mailman.yml"     => "#{release_path}/config/mailman.yml",
    }

    symlink_hash.each do |source, target|
      run "ln -sf #{source} #{target}"
    end
  end

end

set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)

namespace :deploy do
  namespace :assets do

    desc <<-DESC
      Run the asset precompilation rake task. You can specify the full path \
      to the rake executable by setting the rake variable. You can also \
      specify additional environment variables to pass to rake via the \
      asset_env variable. The defaults are:

        set :rake,      "rake"
        set :rails_env, "production"
        set :asset_env, "RAILS_GROUPS=assets"
        set :assets_dependencies, fetch(:assets_dependencies) + %w(config/locales/js)
    DESC
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} #{assets_dependencies.join ' '} | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end

  end
end
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

after "deploy:finalize_update", "my_tasks:symlink"
after :deploy, "deploy:cleanup"

#after "deploy:restart", "sphinx:rebuild"
#after "deploy:restart", "sphinx:restart"
