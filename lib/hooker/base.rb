module Hooker
  class HookerException < Exception; end #nodoc
  
  class Base
    
    # def repository
    #   self.class.init_repository
    # end
    
    class << self
      def repository_path
        @repository_path ||= detect_repository_path
      end
      
      private
        # the repository gets only initialized once!
        def init_repository(repository_path)
          @repo ||= Grit::Repo.new(repository_path)
        end
        
        def detect_repository_path
          separator = Regexp::escape(File::SEPARATOR)
          matchdata = caller[0].gsub(/#{separator}[^#{separator}]*\:.*$/, '').scan(/([^#{separator}]*)#{separator}/)
          matchdata.pop if matchdata.last == ".git"
          matchdata.join(File::SEPARATOR)
        end
    end
  end
end