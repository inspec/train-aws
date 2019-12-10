# A Rakefile defines tasks to help maintain your project.
# Rake provides several task templates that are useful.

#------------------------------------------------------------------#
#                    Rake Default Task
#------------------------------------------------------------------#

# Do not run integration by default
task default: %i{test:unit test:functional}

#------------------------------------------------------------------#
#                    Test Runner Tasks
#------------------------------------------------------------------#
require "rake/testtask"

namespace :test do
  {
    unit: "test/unit/*_test.rb",
    functional: "test/integration/*_test.rb",
    integration: "test/function/*_test.rb",
  }.each do |task_name, glob|
    Rake::TestTask.new(task_name) do |t|
      t.libs.push "lib"
      t.libs.push "test"
      t.test_files = FileList[glob]
      t.verbose = true
      t.warning = false
    end
  end
end

desc "Check the current dependencies against inspec-aws"
task :deps do
  src = `curl -sL https://github.com/inspec/inspec-aws/archive/master.tar.gz | tar xO inspec-aws-master/Gemfile`

  exp = src.lines.grep(/^gem..aws/)
  exp.map! { |s| s[/aws-[\w-]+/] }
  act = File.readlines("train-aws.gemspec").grep(/^  spec.add_dep.*aws-sdk/)
  act.map! { |s| s[/aws-[\w-]+/] }

  puts "# Missing:"
  puts exp - act
  puts
  puts "# Extra?:"
  puts act - exp
end

# #------------------------------------------------------------------#
# #                    Code Style Tasks
# #------------------------------------------------------------------#
require "chefstyle"
require "rubocop/rake_task"
RuboCop::RakeTask.new(:lint) do |task|
  task.options << "--display-cop-names"
end
