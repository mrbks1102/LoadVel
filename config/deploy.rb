lock "3.14.1"
set :application, "RoadVel"
set :repo_url, "git@github.com:mrbks1102/RoadVel.git"
set :branch, "develop" 
set :deploy_to, "/var/www/rails/RoadVel"
set :linked_files, fetch(:linked_files, []).push("config/settings.yml")
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system")
set :keep_releases, 5
set :rbenv_ruby, "2.6.3"
set :log_level, :debug

namespace :deploy do
  desc "Restart application"
  task :restart do
    invoke "unicorn:restart"
  end

  desc "Create database"
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rails, "db:create"
        end
      end
    end
  end

  desc "Run seed"
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rails, "db:seed"
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
