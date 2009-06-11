require File.dirname(__FILE__) + "/../test_helper.rb"

class HookTest < Test::Unit::TestCase
  
  test "Should require a hooktype as a argument when instanciated" do
    assert_raise ArgumentError do
      Hooker::Hook.new()
    end
  end
  
  test "Should instanciate a UpdateHook if its type is a update hook" do
    hook = stub_everything("update_hook")

    Hooker::UpdateHook.expects(:new).returns(hook)
    Hooker::Hook.new(:update)
  end

end

class UpdateHookTest < Test::Unit::TestCase
  test "A update hook should read its parameters correctly" do
    @hook = Hooker::UpdateHook.new([2,4,6])

    assert_equal 2, @hook.ref_name
    assert_equal 4, @hook.old_revision_hash
    assert_equal 6, @hook.new_revision_hash
  end
end
