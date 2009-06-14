$: << File.join(File.dirname(__FILE__), '..', 'lib')
require 'hooker'
require 'spec'
require 'rubygems'
require 'test/unit'
begin; require 'redgreen' unless ENV['TM_FILENAME']; rescue LoadError; end
