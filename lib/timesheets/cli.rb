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

    desc "summary", "See a summary table of time worked"
    option :format
    option :'week-of'
    option :rate
    option :template
    def summary
      Commands::Summary.run(options)
    end
  end
end

