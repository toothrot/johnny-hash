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

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "johnny-hash"
    gem.summary = %Q{Adds json-object-style Hash accessors in Ruby for fun.}
    gem.description = %Q{Read the awful readme for more info.}
    gem.email = "scissorjammer@gmail.com"
    gem.homepage = "http://github.com/toothrot/johnny-hash"
    gem.authors = ["toothrot", "jaknowlden"]
    gem.add_development_dependency "riot", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
