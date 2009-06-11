require File.dirname(__FILE__) + "/../test_helper.rb"

class HookTest < Test::Unit::TestCase
  
  test "A new hook should require a hooktype as a argument" do
    assert_raise ArgumentError do
      Hooker::Hook.new()
    end
  end
  
  test "Should instanciate a UpdateHook if its type is a update hook" do
    Hooker::UpdateHook.expects(:new)
    Hooker::Hook.new(:update)
  end
end


# class UpdateHookTest < Test::Unit::TestCase
#   test "A update hook should read its parameters correctly" do
#     Hooker::Hook.new(:update)
#   end
# end