require 'thor'
require 'terminal-table'
require 'csv'

require "timesheets/commands/base"
require "timesheets/commands/edit"
require "timesheets/commands/start"
require "timesheets/commands/status"
require "timesheets/commands/stop"
require 'timesheets/html_table'
require 'timesheets/csv_table'
require "timesheets/commands/summary"

module Timesheets
  class CLI < Thor
    desc "edit", "Manually edit timesheet data"
    def edit
      Commands::Edit.run
    end

    desc "start", "Begin a work session"
    def start
      Commands::Start.run
    end

    desc "status", "Show current work status"
    def status
      Commands::Status.run
    end

    desc "stop", "End the current work session"
    def stop
      Commands::Stop.run
    end

    option :format, type: :string,
      desc: "ascii, csv, or html.", default: 'ascii'
    option :'week-of', type: :string,
      desc: "Limit summary to the week of YYYY-MM-DD"
    option :rate, type: :numeric,
      desc: "If provided, will be used as an hourly rate to calculate daily and weekly totals."
    option :template, type: :string,
      desc: "Filepath to a custom HTML template. Replaceable macros are: {{styles}}, {{table}}, {{today}}, {{firstDayNice}}, and {{invoiceID}}."
    desc "summary", "See a summary table of time worked"
    def summary
      Commands::Summary.run(options)
    end
  end
end

