module Hooker
  class HookerException < Exception; end #nodoc

  class Base

    def repository
      self.class.repository
    end

    class << self
      def repository_path
        @repository_path ||= detect_repository_path
      end

      def repository
        @repository ||= Grit::Repo.new(repository_path)
      end

      private
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