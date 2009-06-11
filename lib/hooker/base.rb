module Hooker
  class HookerException < Exception; end #nodoc

  class Base

    def repository
      self.class.init_repository
    end

    class << self
      def repository_path
        @repository_path ||= detect_repository_path
      end

      def repository
        init_repository
      end

      private
        # the repository gets only initialized once!
        def init_repository
          @repo ||= Grit::Repo.new(repository_path)
        end

        def detect_repository_path
          separator = Regexp::escape(File::SEPARATOR)
          matchdata = caller_path.gsub(/#{separator}[^#{separator}]*\:.*$/, '').scan(/([^#{separator}]*)#{separator}/)
          matchdata.pop if matchdata.last[0] == ".git"
          matchdata.join(File::SEPARATOR)
        end

        def caller_path
          caller[0]
        end
    end
  end
end