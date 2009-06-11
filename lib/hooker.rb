$: << File.dirname(__FILE__)

require 'hooker/base'
require 'hooker/hook'
require 'hooker/update_hook'

require 'rubygems'

begin
  require 'grit'
rescue LoadError
  puts "seems like Grit is not installed. please install grit with the following command:"
  puts "gem install mojombo-grit"
  exit 1
end
