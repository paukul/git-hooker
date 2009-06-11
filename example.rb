Hooker::Hook.new(:update) do
  commits do
    must_match /some pattern/
  end
end