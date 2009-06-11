module Hooker
  class Hook < Base
    def initialize(hook_type, params)
      delegate_class = "#{hook_type.to_s.capitalize}Hook"
      @delegate = Object.module_eval("Hooker::#{delegate_class}", __FILE__, __LINE__).new(params)
    end
  end
end