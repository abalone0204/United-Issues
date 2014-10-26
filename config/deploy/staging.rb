set :stage, :staging
set :branch, "staging"

# used in case we're deploying multiple versions of the same
# app side by side. Also provides quick sanity checks when looking
# at filepaths
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

# # specify server DNS name, user & roles
server '54.64.218.2', user: 'ubuntu', roles: %w{web app db},ssh_options: {
  port: 22, keys:["/Users/kudenny/Amazon/denny.pem"]
}, primary: true
# server '192.168.0.9', user: 'vagrant', roles: %w{web app db}, primary: true

set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"

# dont try and infer something as important as environment from
# stage name.
set :rails_env, :staging

# number of unicorn workers, this will be reflected in
# the unicorn.rb and the monit configs
set :unicorn_worker_count, 5

# whether we're using ssl or not, used for building nginx
# config file
set :enable_ssl, false
