require 'thor'
require 'terminal-table'
require 'csv'

module Timesheets
  class CLI < Thor
    desc "summary", "See a summary table of time worked"
    def summary
      puts summary_table
    end

    private

    def summary_table
      Terminal::Table.new(headings: ['Weekday', 'Date', 'Start Time', 'End Time', 'Hour(s)']) {|t|
        formatted_entries.each {|entry| t << entry }
        t << :separator
        t << ['', '', '', '', sprintf('%0.02f', total_hours)]

        formatted_entries.first.length.times {|i| t.align_column(i, :right) }
      }
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

    def rows
      @rows ||= CSV.read(filepath)[1..-1]
    end

    def filepath
      File.expand_path(ENV['TIMESHEETS_FILEPATH'] || '~/.timesheets.csv')
    end

    def hours_in_entry(entry)
      entry.map(&:to_i).reverse.reduce(:-) / 3600.0
    end
  end
end
