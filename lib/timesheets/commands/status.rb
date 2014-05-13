module Timesheets
  module Commands
    class Status < Base
      def run
        strings = []
        if session_in_progress?
          strings << "Current work session has been active for #{active_time}."
        else
          strings << "Not currently working."
        end
        strings << "Total time today is #{total_time_today}."
				logger.log strings.join(' ')
      end

      private

      def active_time(the_entries = [entries.last])
        hoursf = the_entries.map {|entry| hours_in_entry(entry) }.reduce(:+)
        return "0 minutes" unless hoursf
        hours = hoursf.to_i
        mins = ((hoursf - hours) * 60).to_i

        [pluralize('hour', hours), pluralize('minute', mins)]
          .reject {|string| string == "0 hours" }
          .join(', ')
      end

      def total_time_today
        active_time(todays_entries)
      end

      def pluralize(word, n)
        n == 1 && "#{n} #{word}" || "#{n} #{word}s"
      end
    end
  end
end

