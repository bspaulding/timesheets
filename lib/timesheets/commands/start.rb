module Timesheets
  module Commands
    class Start < Base
      def run
        if session_in_progress?
          puts "Session already in progress"
        else
          time = Time.new
          add_new_entry(time)
          puts "Started session at #{time}"
        end
      end

      private

      def session_in_progress?
        rows.last.last.nil?
      end

      def add_new_entry(time)
        File.open(filepath, 'a') {|f| f.write("#{time},") }
      end
    end
  end
end
