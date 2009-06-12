module Hooker
  class Commit
    attr_reader :raw_commit
    
    def initialize(grit_commit)
      @raw_commit = grit_commit
    end
    
    class << self
      def from_commits(grit_commits)
        grit_commits.inject([]) do |commits, grit_commit|
          commits << new(grit_commit)
        end
      end
    end
  end
end