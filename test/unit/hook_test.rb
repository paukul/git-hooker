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
    Hooker::Hook.new(:update, [])
  end

  test "Should pass the parameters from the hook creation to its delegate" do
    params = [1,2,3]
    Hooker::UpdateHook.expects(:new).with(params)
    Hooker::Hook.new(:update, params)
  end
end

class UpdateHookTest < Test::Unit::TestCase
  test "A update hook should read its parameters correctly" do
    ref_name = "refs/hreads/master"
    old_revision_hash = "1"*40
    new_revision_hash = "2"*40
    
    hook = Hooker::UpdateHook.new([ref_name, old_revision_hash, new_revision_hash])
    
    assert_equal ref_name, hook.ref_name
    assert_equal old_revision_hash, hook.old_revision_hash
    assert_equal new_revision_hash, hook.new_revision_hash
  end
  
  # test "should have a commits method which gives access to every commit object of the update" do
  #   hook = Hooker::UpdateHook.new(valid_attributes)
  #   assert_equal [], hook.commits
  # end
end

def valid_attributes(params = {})
  params = {
    :ref_name => "refs/heads/master",
    :old_revision_hash => "1"*40,
    :new_revision_hash => "2"*40
  }.merge(params)
  [params[:ref_name], params[:old_revision_hash], params[:new_revision_hash]]
end
