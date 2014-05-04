module Timesheets
  module Commands
    class Status < Base
      def run
        if session_in_progress?
          puts "Current work session has been active for #{active_time}"
        else
          puts "Not currently working"
        end
      end

      private

      def active_time
        hoursf = hours_in_entry(entries.last)
        hours = hoursf.to_i
        mins = ((hoursf - hours) * 60).to_i

        [pluralize('hour', hours), pluralize('minute', mins)]
          .reject {|string| string[0] == "0" }
          .join(', ')
      end

      def pluralize(word, n)
        n == 1 && "#{n} #{word}" || "#{n} #{word}s"
      end
    end
  end
end

