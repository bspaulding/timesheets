require 'thor'
require 'terminal-table'
require 'csv'

require "timesheets/commands/base"
require "timesheets/commands/summary"

module Timesheets
  class CLI < Thor
    desc "summary", "See a summary table of time worked"
    def summary
      Commands::Summary.run
    end
  end
end
