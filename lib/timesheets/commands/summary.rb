module Timesheets
  module Commands
    class Summary < Base
      def run
        puts summary_table
      end

      private

      def summary_table
        Terminal::Table.new(headings: heading) {|t|
          entries_by_week.each_with_index {|entries, index|
            format_entries(entries).each {|entry| t << entry }
            t << :separator
            t << (heading.length - 2).times.map { '' } + ['Weekly Total:', sprintf('%0.02f', hours_in_entries(entries))]
            t << :separator
          }

          t << (heading.length - 2).times.map { '' } + ['Total:', sprintf('%0.02f', total_hours)]

          heading.length.times {|i| t.align_column(i, :right) }
        }
      end

      def heading
        ['Weekday', 'Date', 'Time', 'Hour(s)']
      end

      def total_hours
        hours_in_entries(entries)
      end

      def hours_in_entries(the_entries)
        the_entries.map {|entry| hours_in_entry(entry) }.reduce(:+)
      end

      def entries_by_week
        @entries_by_week ||= entries.group_by {|entry| entry.first.strftime('%U') }.values
      end

      def format_entries(entries)
        entries.group_by {|entry|
            entry.first.strftime('%B %e, %Y')
        }.map {|day, entries|
          [
            entries.first.first.strftime('%A'),
            day,
            entries.map {|entry|
              entry.map {|time|
                time.strftime('%l:%M%p')
              }.join(' - ')
            }.join(', '),
            sprintf('%0.02f', entries.map {|entry| hours_in_entry(entry) }.reduce(:+))
          ].flatten
        }
      end
    end
  end
end
