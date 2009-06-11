module Hooker
  class UpdateHook < Hook
    attr_reader :ref_name, :old_revision_hash, :new_revision_hash
    
    def initialize(args)
      @ref_name, @old_revision_hash, @new_revision_hash = args[0..2]
    end
  end
end