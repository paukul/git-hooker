require File.dirname(__FILE__) + "/../spec_helper.rb"

module HookHelpers
  def valid_attributes(params = {})
    params = {
      :ref_name => "refs/heads/master",
      :old_revision_hash => "1"*40,
      :new_revision_hash => "2"*40
    }.merge(params)
    [params[:ref_name], params[:old_revision_hash], params[:new_revision_hash]]
  end
end

module Hooker
  describe Hook do
    include HookHelpers
    
    it "should require a hooktype as a argument when instanciated" do
      lambda{
        Hook.new()
      }.should raise_error(ArgumentError)
    end
    
    it "should instanciate a UpdateHook if its type is a update hook" do
      hook = mock("update_hook")

      Hooker::UpdateHook.expects(:new).returns(hook)
      Hooker::Hook.new(:update, [])
    end
    
    it "should pass the parameters from the hook creation to its delegate" do
      params = valid_attributes # find them in the helper method at the end of the file
      Hooker::UpdateHook.expects(:new).with(params)
      Hooker::Hook.new(:update, params)
    end
  end

  describe UpdateHook do
    include HookHelpers

    it "should read its parameters correctly" do
      @old_revision_hash = "1"*40
      @new_revision_hash = "2"*40
      
      ref_name = "refs/hreads/master"
      hook = Hooker::UpdateHook.new([ref_name, @old_revision_hash, @new_revision_hash])
    
      hook.ref_name.should == ref_name
      hook.old_revision_hash.should == @old_revision_hash
      hook.new_revision_hash.should == @new_revision_hash
    end
  end
  
  describe UpdateHook, "#commits" do
    include HookHelpers
    
    it "should give access to every commit object of the update" do
      hook = Hooker::UpdateHook.new(valid_attributes)
      repo = mock('repository')

      repo.expects(:commits_between).returns([])
      Grit::Repo.expects(:new).returns(repo)
      hook.commits.should == []
    end
    
    it "should be wrapped commits" do
      hook = UpdateHook.new(valid_attributes)
      repo = mock('repository')
      repo.expects(:commits_between).returns([nil])
      UpdateHook.expects(:repository).returns(repo)

      commits = hook.commits
      commits.should be_a(Array)
      commits[0].should be_a(Commit)
    end
    
    it "schould be usable for registering message patterns" do
      pending do
        hook = UpdateHook.new(valid_attributes)
        repo = mock('repository')
        commit_1 = mock('commit_1', :message => "peter")
        commit_2 = mock('commit_2', :message => "marry")
        repo.expects(:commits_between).returns([commit_1, commit_2])
        UpdateHook.expects(:repository).returns(repo)
      
        repo.commits
      end
    end
  end
end