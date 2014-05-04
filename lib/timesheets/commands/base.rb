module Timesheets
  module Commands
    class Base
      def self.run
        new.run
      end

      private

      def session_in_progress?
        rows.last.last.nil?
      end

      def rows
        @rows ||= CSV.read(filepath)[1..-1]
      end

      def filepath
        File.expand_path(ENV['TIMESHEETS_FILEPATH'] || '~/.timesheets.csv')
      end
    end
  end
end
