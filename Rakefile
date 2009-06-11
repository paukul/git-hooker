require 'rake'
require "rake/clean"
require 'rake/testtask'
require 'rake/rdoctask'

$:.unshift 'lib'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = Dir['test/**/*_test.rb']
end