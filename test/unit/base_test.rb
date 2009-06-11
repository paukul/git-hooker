require File.dirname(__FILE__) + "/../test_helper.rb"

class BaseTest < Test::Unit::TestCase
  test "The repository path should get detected correctly if in a unix environment" do
    repository_path = "/path/to/some_repository.git"
    caller_path = "/path/to/some_repository.git/hooks/update:12:in `bla`"
    caller.expects(:[]).with(0).returns
    assert_equal repository_path, Hooker::Base.repository_path 
  end
end
