require 'simplecov'
SimpleCov.start

require 'timesheets'
require 'minitest/autorun'

TIMESHEETS_FILEPATH='./tmp/timesheets.csv'
FileUtils.mkdir_p('./tmp')
File.open(TIMESHEETS_FILEPATH, 'w+') {|f| f.write('Start,End') }

