require 'rubygems'

require 'rake'
require 'rake/testtask'

#
# Other rake tasks

Dir[File.dirname(__FILE__) + "/lib/tasks/*.rake"].each { |rake_task| load rake_task }

#
# Console!

task(:console) { exec "irb -r boot" }

#
# Testing

Rake::TestTask.new("test") do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = false
end
Rake::Task["test"].instance_variable_set(:@full_comment, nil) # Dumb dumb dumb
Rake::Task["test"].comment = "Run the tests!"

task :default => :test

