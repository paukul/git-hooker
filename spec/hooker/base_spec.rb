require File.dirname(__FILE__) + "/../spec_helper.rb"

module Hooker
  describe Base do
    before(:each) do
      Hooker::Base.instance_variable_set :@repository_path, nil
    end
    
    it "should detect the repository path correctly" do
      bare_repository_path = "/path/to/some_repository.git"
      bare_caller_path = "/path/to/some_repository.git/hooks/update:12:in `bla`"
      Hooker::Base.should_receive(:caller_path).and_return(bare_caller_path)

      Hooker::Base.repository_path.should == bare_repository_path 
    end
    
    it "A workspace repository path should get detected correctly" do
      workspace_repository_path = "/path/to/some_repository"
      workspace_caller_path = "/path/to/some_repository/.git/hooks/update:12:in `bla`"
      Hooker::Base.should_receive(:caller_path).and_return(workspace_caller_path)

      Hooker::Base.repository_path.should == workspace_repository_path
    end

    it "Access to the Repository should be given" do
      repo      = mock('repository')
      repo_path = "repo_path"

      Hooker::Base.stub!(:repository_path).and_return(nil)
      Grit::Repo.should_receive(:new).once.and_return(repo)

      Hooker::Base.repository
      Hooker::Base.repository
    end
  end
end
