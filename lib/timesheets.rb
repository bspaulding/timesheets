module Timesheets
	class Logger
		def log(string)
			puts string
		end
	end
end

require "timesheets/version"
require "timesheets/cli"
