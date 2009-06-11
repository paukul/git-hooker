require File.dirname(__FILE__) + "/../test_helper.rb"

class BaseTest < Test::Unit::TestCase
  def setup
    Hooker::Base.instance_variable_set :@repository_path, nil
  end
  
  test "A bare repository path should get detected correctly" do
    bare_repository_path = "/path/to/some_repository.git"
    bare_caller_path = "/path/to/some_repository.git/hooks/update:12:in `bla`"
    Hooker::Base.expects(:caller_path).returns(bare_caller_path)
    
    assert_equal bare_repository_path, Hooker::Base.repository_path
  end
  
  test "A workspace repository path should get detected correctly" do
    workspace_repository_path = "/path/to/some_repository"
    workspace_caller_path = "/path/to/some_repository/.git/hooks/update:12:in `bla`"
    Hooker::Base.expects(:caller_path).returns(workspace_caller_path)
    
    assert_equal workspace_repository_path, Hooker::Base.repository_path
  end
  
  test "Access to the Repository should be given" do
    repo      = mock('repository')
    repo_path = "repo_path"
    
    Hooker::Base.expects(:repository_path).returns(repo_path)
    Grit::Repo.expects(:new).with(repo_path).once.returns(repo)
    
    Hooker::Base.repository
    Hooker::Base.repository
  end
end
