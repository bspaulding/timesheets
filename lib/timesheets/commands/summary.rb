module Timesheets
  module Commands
    class Summary < Base
      def run
        puts summary_table
      end

      private

      def tableClass
				{
					'html'  => Timesheets::HTMLTable,
					'csv'   => Timesheets::CSVTable,
					'ascii' => Terminal::Table
				}[options[:format]] || Terminal::Table
      end

      def table_renderer(&block)
        tableClass.new({ headings: heading, template: options[:template] }, &block)
      end

      def summary_table
        table_renderer {|t|
          entries_by_week.each_with_index {|entries, index|
            rows_for_entries(entries).each {|row| t << row }
						t << :separator unless index == entries_by_week.length - 1
					}
          t << total_row(entries) unless options['week-of']

          (heading.length - 1).times {|i| t.align_column(i, :right) }
        }
      end

      def rows_for_entries(entries)
        format_entries(entries) + [
          :separator,
          total_row(entries)
        ]
      end

      def heading
        the_heading = ['Weekday', 'Date', 'Time', 'Hour(s)']

				the_heading += ['Hourly Rate', 'Total'] if options[:rate]

				the_heading
      end

      def total_row(entries)
				padN = heading.length - 2
				padN -= 2 if options[:rate]
        the_row = padN.times.map { '' } + ['Total:', sprintf('%0.02f', hours_in_entries(entries))]

				if options[:rate]
					the_row += ['', "$#{comma_numbers(hours_in_entries(entries).to_f * options[:rate].to_f)}"]
				end

				the_row
      end

			def comma_numbers(number, delimiter = ',')
				sprintf('%0.02f', number).reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
			end

      def hours_in_entries(the_entries)
        the_entries.map {|entry| hours_in_entry(entry) }.reduce(:+)
      end

      def entries_by_week
        @entries_by_week ||= entries.group_by {|entry| entry.first.strftime('%U') }.values
      end

      def entries
        the_entries = super

				if options['week-of']
          week_num = DateTime.parse(options['week-of']).strftime("%U")
          the_entries = the_entries.select {|entry| entry.first.strftime("%U") == week_num }
				end

				the_entries
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
          entry = [
            entries.first.first.strftime('%A'),
            day,
						times_for_entries(entries),
            sprintf('%0.02f', hours_in_entries(entries))
					].flatten

					if options[:rate]
						entry << sprintf('$%0.02f', options[:rate])
						entry << sprintf('$%0.02f', hours_in_entries(entries).to_f * options[:rate].to_f)
					end

					entry
        }
      end
    end
  end
end
