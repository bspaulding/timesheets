require 'thor'
require 'terminal-table'
require 'csv'

require "timesheets/commands/base"
require "timesheets/commands/summary"
require "timesheets/commands/start"

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
  end
end
