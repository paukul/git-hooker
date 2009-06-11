module Hooker
  class Hook
    def initialize(hook_type)
      delegate_class = "#{hook_type.to_s.capitalize}Hook"
      @delegate = Object.module_eval("Hooker::#{delegate_class}", __FILE__, __LINE__).new(ARGV)
    end
  end
end