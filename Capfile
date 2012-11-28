# load 'deploy'
# Uncomment if you are using Rails' asset pipeline
# load 'deploy/assets'
# load 'config/deploy'
#load 'config/deploy/assets'


load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks
load 'deploy/assets'


#load 'config/deploy/assets'
#load 'config/deploy/delayed_job'
#load 'config/deploy/sphinx'