require File.dirname(__FILE__) + "/../spec_helper.rb"

module Hooker
  describe Base do
    before(:each) do
      Hooker::Base.instance_variable_set :@repository_path, nil
    end
    
    it "should detect the repository path correctly" do
      bare_repository_path = "/path/to/some_repository.git"
      bare_caller_path = "/path/to/some_repository.git/hooks/update:12:in `bla`"
      Base.expects(:caller_path).returns(bare_caller_path)

      Base.repository_path.should == bare_repository_path 
    end
    
    it "A workspace repository path should get detected correctly" do
      workspace_repository_path = "/path/to/some_repository"
      workspace_caller_path = "/path/to/some_repository/.git/hooks/update:12:in `bla`"
      Base.expects(:caller_path).returns(workspace_caller_path)

      Base.repository_path.should == workspace_repository_path
    end

    it "Access to the Repository should be given" do
      repo      = mock('repository')
      repo_path = "repo_path"

      Base.stubs(:repository_path).returns(nil)
      Grit::Repo.expects(:new).once.returns(repo)

      Base.repository
      Base.repository
    end
  end
end
