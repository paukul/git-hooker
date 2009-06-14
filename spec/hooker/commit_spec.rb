require File.dirname(__FILE__) + "/../spec_helper.rb"

module Hooker
  describe Commit do
    it "should wrap a commit object from grit" do
      grit_commit = Object.new

      lambda{Hooker::Commit.new}.should raise_error(ArgumentError)
      
      commit = Hooker::Commit.new(grit_commit)
      commit.raw_commit.should == grit_commit
    end

    it "should wrap multiple commits" do
      grit_commits = [Object.new, Object.new]
      commits = Hooker::Commit.from_commits grit_commits
      commits.map {|commit| commit.raw_commit }.should == grit_commits
    end
  end
end
