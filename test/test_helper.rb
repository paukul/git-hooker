$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'test/unit'
require 'hooker'
begin; require 'redgreen' unless ENV['TM_FILENAME']; rescue LoadError; end

# This allows you to use the 'test "something should behave that way" do' syntax for plain test/unit tests
# See ActiveSupport::Testing::Declarative:
# http://github.com/rails/rails/blob/master/activesupport/lib/active_support/testing/declarative.rb
def test(name, &block)
  test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
  defined = instance_method(test_name) rescue false
  raise "#{test_name} is already defined in #{self}" if defined
  if block_given?
    define_method(test_name, &block)
  else
    define_method(test_name) do
      flunk "No implementation provided for #{name}"
    end
  end
end