require 'lib/hooker'

Hooker::Hook.new(:update, nil) do
  commits do
    must_match /some pattern/
  end
end