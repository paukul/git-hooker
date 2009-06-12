require File.dirname(__FILE__) + "/../test_helper.rb"

class CommitTest < Test::Unit::TestCase
  test "A commit should wrap a commit object from grit" do
    grit_commit = Object.new

    assert_raise ArgumentError do 
      Hooker::Commit.new
    end
    commit = Hooker::Commit.new(grit_commit)
    assert_equal grit_commit, commit.raw_commit
  end
  
  test "Should wrap multiple commits" do
    grit_commits = [Object.new, Object.new]
    commits = Hooker::Commit.from_commits grit_commits
    assert_equal grit_commits, commits.map {|commit| commit.raw_commit }
  end
end