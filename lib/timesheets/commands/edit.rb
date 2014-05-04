module Timesheets
  module Commands
    class Edit < Base
      def run
        exec("#{editor} #{filepath}")
      end

      private

      def editor
        env_editor || git_editor || 'vim'
      end

      def env_editor
        env_editor_set? && env_editor_name
      end

      def env_editor_set?
        env_editor_name.length > 0
      end

      def env_editor_name
        ENV['EDITOR'].to_s
      end

      def git_editor
        git? && git_editor_set? && git_editor_name
      end

      def git?
        %x[which git].length > 0
      end

      def git_editor_set?
        git_editor_name.length > 0
      end

      def git_editor_name
        %x[git config core.editor]
      end
    end
  end
end
