server '139.59.55.24', port: 22, roles: [:web, :app, :db], primary: true


set :stage, :staging
set :branch, 'staging'
set :repo_url, "git@gitlab.builder.ai:clientprojects/ongoing/pepsidrc/pepsidrc_ror.git"
set :puma_env, 'staging'
