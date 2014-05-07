module Timesheets
  module Commands
    class Summary < Base
      def run
        puts summary_table
      end

      private

      def summary_table
        Terminal::Table.new(headings: heading) {|t|
          entries_by_week.map {|entries|
            rows_for_entries(entries).each {|row| t << row }
	  }
          t << total_row(entries)

          heading.length.times {|i| t.align_column(i, :right) }
        }
      end

      def rows_for_entries(entries)
        format_entries(entries) + [
          :separator,
          total_row(entries),
          :separator
        ]
      end

      def heading
        ['Weekday', 'Date', 'Time', 'Hour(s)']
      end

      def total_row(entries)
        (heading.length - 2).times.map { '' } + ['Total:', sprintf('%0.02f', hours_in_entries(entries))]
      end

      def hours_in_entries(the_entries)
        the_entries.map {|entry| hours_in_entry(entry) }.reduce(:+)
      end

      def entries_by_week
        @entries_by_week ||= entries.group_by {|entry| entry.first.strftime('%U') }.values
      end

      def entries_by_day(entries)
        entries.group_by {|entry|
          entry.first.strftime('%B %e, %Y')
        }
      end

      def times_in_entry(entry)
        entry.map {|time| time.strftime('%l:%M%p') }.join(' - ')
      end

      def times_for_entries(entries)
	entries.map {|entry| times_in_entry(entry) }.join(', ')
      end

      def format_entries(entries)
	entries_by_day(entries).map {|day, entries|
          [
            entries.first.first.strftime('%A'),
            day,
	    times_for_entries(entries),
            sprintf('%0.02f', hours_in_entries(entries))
          ].flatten
        }
      end
    end
  end
end
