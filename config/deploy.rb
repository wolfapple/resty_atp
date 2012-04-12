# -*- encoding : utf-8 -*-
require "bundler/capistrano"

set :application, "goodoc"
set :repository,  "git@github.com:Fast-Track-Asia/goodoc.git"
set :scm, :git
set :ssh_options, { :forward_agent => true}
set :rails_env, "production"

default_environment["RAILS_ENV"] = 'production'
default_environment["RUBY_VERSION"] = "ruby-1.9.3-p125"

default_run_options[:shell] = 'bash'

task :production do
  default_environment["PATH"]         = "/home/www/.rvm/gems/ruby-1.9.3-p125/bin:/home/www/.rvm/gems/ruby-1.9.3-p125@global/bin:/home/www/.rvm/rubies/ruby-1.9.3-p125/bin:/home/www/.rvm/bin:/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
  default_environment["GEM_HOME"]     = "/home/www/.rvm/gems/ruby-1.9.3-p125"
  default_environment["GEM_PATH"]     = "/home/www/.rvm/gems/ruby-1.9.3-p125:/home/www/.rvm/gems/ruby-1.9.3-p125@global"
  set :branch, "origin/production"
  set :deploy_to, "/home/www/goodoc"
  set :user, "www"
  set :password, "goodoc!@#"
  server "1.234.2.182", :app, :web, :db, :primary => true
end

task :dev do
  default_environment["PATH"]         = "/home/goodoc/.rvm/gems/ruby-1.9.3-p125/bin:/home/goodoc/.rvm/gems/ruby-1.9.3-p125@global/bin:/home/goodoc/.rvm/rubies/ruby-1.9.3-p125/bin:/home/goodoc/.rvm/bin:/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
  default_environment["GEM_HOME"]     = "/home/goodoc/.rvm/gems/ruby-1.9.3-p125"
  default_environment["GEM_PATH"]     = "/home/goodoc/.rvm/gems/ruby-1.9.3-p125:/home/goodoc/.rvm/gems/ruby-1.9.3-p125@global"
  set :branch, "origin/dev"
  set :deploy_to, "/home/goodoc/rails_project/goodoc"
  set :user, "goodoc"
  set :password, "goodoc!@#"
  server "1.234.2.149", :app, :web, :db, :primary => true
end

namespace :deploy do
  desc "Deploy your application"
  task :default do
    update
    restart
  end
  
  task :migrate do
    run "cd #{deploy_to}; bundle exec rake db:migrate"
  end
  
  task :bundle do
    run "cd #{deploy_to}; bundle"
  end

  desc "Setup your git-based deployment app"
  task :setup, :except => { :no_release => true } do
    # run "mkdir /rails_project"
    # run "git clone #{repository} #{deploy_to}"
    # run "cd #{deploy_to}; git checkout work"
    # run "cp #{deploy_to}/config/database.yml.sample #{deploy_to}/config/database.yml"
    # run "bundle install"
    # run "bundle exec rake db:create;bundle exec rake db:migration"
    # start
  end
  
  task :update do
    transaction do
      update_code
    end
  end

  desc "Update the deployed code."
  task :update_code, :except => { :no_release => true } do
    run "cd #{deploy_to}; git fetch origin; git reset --hard #{branch}"
  end

  desc "Update the database (overwritten to avoid symlink)"
  task :migrations do
    transaction do
      update_code
    end
    migrate
    restart
  end
  
  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{deploy_to}/tmp/pids/unicorn.pid`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{deploy_to} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{deploy_to}/tmp/pids/unicorn.pid`"
  end

  namespace :rollback do
    desc "Moves the repo back to the previous version of HEAD"
    task :repo, :except => { :no_release => true } do
      set :branch, "HEAD@{1}"
      deploy.default
    end

    desc "Rewrite reflog so HEAD@{1} will continue to point to at the next previous release."
    task :cleanup, :except => { :no_release => true } do
      run "cd #{deploy_to}; git reflog delete --rewrite HEAD@{1}; git reflog delete --rewrite HEAD@{1}"
    end

    desc "Rolls back to the previously deployed version."
    task :default do
      rollback.repo
      rollback.cleanup
    end
  end
end

def run_rake(cmd)
  run "cd #{deploy_to}; #{rake} #{cmd}"
end
