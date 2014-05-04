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

      def hours_in_entry(entry)
        entry.map(&:to_i).reverse.reduce(:-) / 3600.0
      end

      def entries
        @entries ||= rows.map {|row| row.map {|dt| DateTime.parse(dt || Time.now.to_s).to_time } }
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
