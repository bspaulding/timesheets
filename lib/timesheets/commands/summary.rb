module Timesheets
  module Commands
    class Summary < Base
      def run
        puts summary_table
      end

      private

      def summary_table
        Terminal::Table.new(headings: ['Weekday', 'Date', 'Start Time', 'End Time', 'Hour(s)']) {|t|
          formatted_entries.each {|entry| t << entry }
          t << :separator
          t << (formatted_entries.first.length - 1).times.map { '' } + [sprintf('%0.02f', total_hours)]

          formatted_entries.first.length.times {|i| t.align_column(i, :right) }
        }
      end

      def hours_in_entry(entry)
        entry.map(&:to_i).reverse.reduce(:-) / 3600.0
      end

      def total_hours
        entries.map {|entry| hours_in_entry(entry) }.reduce(:+)
      end

      def entries
        @entries ||= rows.map {|row| row.map {|dt| DateTime.parse(dt).to_time } }
      end

      def formatted_entries
        @formatted_entries ||= entries.map {|entry|
          [
            entry.first.strftime('%A'),
            entry.first.strftime('%B %e, %Y'),
            entry.map {|time|
              time.strftime('%l:%M%p')
            },
            sprintf('%0.02f', hours_in_entry(entry))
          ].flatten
        }
      end
    end
  end
end
