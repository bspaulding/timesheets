require 'thor'
require 'terminal-table'
require 'csv'

require "timesheets/commands/base"
require "timesheets/commands/edit"
require "timesheets/commands/start"
require "timesheets/commands/status"
require "timesheets/commands/stop"
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
    def summary
      Commands::Summary.run
    end
  end
end

