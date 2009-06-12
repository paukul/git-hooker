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
    params = valid_attributes # find them in the helper method at the end of the file
    Hooker::UpdateHook.expects(:new).with(params)
    Hooker::Hook.new(:update, params)
  end
end

class UpdateHookTest < Test::Unit::TestCase
  def setup
    @old_revision_hash = "1"*40
    @new_revision_hash = "2"*40
  end

  test "A update hook should read its parameters correctly" do
    ref_name = "refs/hreads/master"
    hook = Hooker::UpdateHook.new([ref_name, @old_revision_hash, @new_revision_hash])
    
    assert_equal ref_name, hook.ref_name
    assert_equal @old_revision_hash, hook.old_revision_hash
    assert_equal @new_revision_hash, hook.new_revision_hash
  end

  test "should have a commits method which gives access to every commit object of the update" do
    attributes        = valid_attributes({:old_revision_hash => @old_revision_hash, :new_rev_hash => @new_revision_hash})
    hook = Hooker::UpdateHook.new(attributes)
    repo = Object.new
    repo.stubs(:commits_between).with(@old_revision_hash, @new_revision_hash).returns([])
    Grit::Repo.stubs(:new).returns(repo)

    assert_equal [], hook.commits
  end
  
  # test "the commits method schould be usable for executing code in the context of every commit" do
  #   hook = Hooker::UpdateHook.new(valid_attributes)
  #   repo = Object.new
  #   commit_1 = mock('commit_1', :message => "peter")
  #   commit_2 = mock('commit_2', :message => "marry")
  #   repo.expects(:commits_between).returns([commit_1, commit_2])
  #   Grit::Repo.stubs(:new).returns(repo)
  #
  #   hook.commits do
  #     message
  #   end
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
