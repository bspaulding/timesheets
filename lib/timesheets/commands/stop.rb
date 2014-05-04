module Timesheets
  module Commands
    class Stop < Base
      def run
        if session_in_progress?
          time = Time.new
          close_last_entry(time)
          puts "Ended session at #{time}"
        else
          puts "No session in progress"
        end
      end

      private

      def close_last_entry(time)
        File.open(filepath, 'a') {|f| f.write("#{time}\n") }
      end
    end
  end
end


