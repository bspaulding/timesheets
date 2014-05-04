require 'thor'
require 'terminal-table'
require 'csv'

require "timesheets/commands/base"
require "timesheets/commands/summary"
require "timesheets/commands/start"
require "timesheets/commands/edit"

module Timesheets
  class CLI < Thor
    desc "summary", "See a summary table of time worked"
    def summary
      Commands::Summary.run
    end

    desc "start", "Begin a work session"
    def start
      Commands::Start.run
    end

    desc "edit", "Manually edit timesheet data"
    def edit
      Commands::Edit.run
    end
  end
end

