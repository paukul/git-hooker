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
      hook = mock("update_hook").as_null_object

      Hooker::UpdateHook.should_receive(:new).and_return(hook)
      Hooker::Hook.new(:update, [])
    end
    
    it "should pass the parameters from the hook creation to its delegate" do
      params = valid_attributes # find them in the helper method at the end of the file
      Hooker::UpdateHook.should_receive(:new).with(params)
      Hooker::Hook.new(:update, params)
    end
  end

  describe UpdateHook do
    include HookHelpers
    
    before(:all) do
      @old_revision_hash = "1"*40
      @new_revision_hash = "2"*40
    end
  
    it "should read its parameters correctly" do
      ref_name = "refs/hreads/master"
      hook = Hooker::UpdateHook.new([ref_name, @old_revision_hash, @new_revision_hash])
    
      hook.ref_name.should == ref_name
      hook.old_revision_hash.should == @old_revision_hash
      hook.new_revision_hash.should == @new_revision_hash
    end
    
    it "should have a commits method which gives access to every commit object of the update" do
      hook = Hooker::UpdateHook.new(valid_attributes({:old_revision_hash => @old_revision_hash, :new_rev_hash => @new_revision_hash}))
      repo = mock('repository')

      repo.should_receive(:commits_between).with(@old_revision_hash, @new_revision_hash).and_return([])
      Grit::Repo.should_receive(:new).and_return(repo)
      hook.commits.should == []
    end
    
    describe "#commits" do
      it "should be wrapped commits" do
        hook = Hooker::UpdateHook.new(valid_attributes)
        repo = mock('repository')
        repo.should_receive(:commits_between).and_return([nil])
        UpdateHook.should_receive(:repository).and_return(repo)

        commits = hook.commits
        commits.should be_a(Array)
        commits[0].should be_a(Hooker::Commit)
      end
      
      xit "schould be usable for registering message patterns" do
        hook = Hooker::UpdateHook.new(valid_attributes)
        repo = mock('repository')
        commit_1 = mock('commit_1', :message => "peter")
        commit_2 = mock('commit_2', :message => "marry")
        repo.should_receive(:commits_between).and_return([commit_1, commit_2])
        UpdateHook.should_receive(:repository).and_return(repo)
        
        repo.commits do
          message.should == "peter"
        end
      end
    end
  end
end