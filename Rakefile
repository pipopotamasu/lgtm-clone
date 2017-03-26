# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :install do
  bundle install
end

desc 'rspecのテストを実行(全ファイル)'
task :test do
  bundle exec rspec
end

# ex) rake target=spec/models test_target
desc 'rspecのテストを実行(ファイル指定あり)'
task :test_target do
  bundle exec rspec ENV['target']
end
