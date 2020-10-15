# frozen_string_literal: true

lock '3.14.1'
set :application, 'rails-the-city'
set :deploy_to, '/var/www/html/rails-the-city'
set :repo_url,  'git@github.com:cerico/rails-the-city.git'
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :branch, 'main'
set :linked_files, %w{config/master.key}
set :rbenv_type, :user
set :rbenv_ruby, '2.6.5'

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
