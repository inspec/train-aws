# A Rakefile defines tasks to help maintain your project.
# Rake provides several task templates that are useful.

#------------------------------------------------------------------#
#                    Rake Default Task
#------------------------------------------------------------------#

# Do not run integration by default
task default: [:'test:unit', :'test:functional']

#------------------------------------------------------------------#
#                    Test Runner Tasks
#------------------------------------------------------------------#
require 'rake/testtask'

namespace :test do
  {
    unit: 'test/unit/*_test.rb',
    functional: 'test/integration/*_test.rb',
    integration: 'test/function/*_test.rb',
  }.each do |task_name, glob|
    Rake::TestTask.new(task_name) do |t|
      t.libs.push 'lib'
      t.libs.push 'test'
      t.test_files = FileList[glob]
      t.verbose = true
      t.warning = false
    end
  end
end

# #------------------------------------------------------------------#
# #                    Code Style Tasks
# #------------------------------------------------------------------#
# require 'rubocop/rake_task'

# RuboCop::RakeTask.new(:lint) do |t|
#   # Choices of rubocop rules to enforce are deeply personal.
#   # Here, we set things up so that your plugin will use the Bundler-installed
#   # train gem's copy of the Train project's rubocop.yml file (which
#   # is indeed packaged with the train gem).
#   require 'train/globals'
#   train_rubocop_yml = File.join(Train.src_root, '.rubocop.yml')

#   t.options = ['--display-cop-names', '--config', train_rubocop_yml]
# end
