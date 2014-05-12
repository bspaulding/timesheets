# Timesheets

A CLI for managing timesheets.

[![Gem Version](https://badge.fury.io/rb/timesheets.svg)](http://badge.fury.io/rb/timesheets)

## Installation

Install it via RubyGems:

    $ gem install timesheets

## Usage

### Help / Commands

Run `timesheets` to see a list of available commands:

    $ timesheets
    Commands:
      timesheets edit            # Manually edit timesheet data
      timesheets help [COMMAND]  # Describe available commands or one specific command
      timesheets start           # Begin a work session
      timesheets status          # Show current work status
      timesheets stop            # End the current work session
      timesheets summary         # See a summary table of time worked


### Edit

Opens the underlying spreadsheet (CSV) in your configured editor. Tries `$EDITOR`, then `git config core.editor`, then defaults to `vim`.

    $ timesheets edit

### Start

Starts a session.

    $ timesheets start
    Started session at 2014-05-04 13:47:33 -0500

### Status

Shows the status of the current work session, if any.

    $ timesheets status
    Current work session has been active for 8 minutes

### Stop

Ends the current work session, if any.

    $ timesheets stop
    Ended session at 2014-05-04 14:38:42 -0500

### Summary

A neat ASCII table report, including total hours.

    $ timesheets summary
    +-----------+----------------+--------------------------------------+---------+
    | Weekday   | Date           | Time                                 | Hour(s) |
    +-----------+----------------+--------------------------------------+---------+
    |    Monday | April 28, 2014 | 11:00AM -  1:00PM,  2:00PM -  7:00PM |    7.00 |
    |   Tuesday | April 29, 2014 | 10:00AM -  1:00PM,  1:30PM -  7:30PM |    9.00 |
    | Wednesday | April 30, 2014 |                    10:00AM -  6:00PM |    8.00 |
    |  Thursday |   May  1, 2014 |                     9:15AM -  5:45PM |    8.50 |
    |    Friday |   May  2, 2014 |  9:30AM - 11:30AM,  1:30PM -  6:15PM |    6.75 |
    +-----------+----------------+--------------------------------------+---------+
    |           |                |                        Weekly Total: |   39.25 |
    +-----------+----------------+--------------------------------------+---------+
    |    Monday |   May  5, 2014 |  9:30AM - 12:11PM,  1:05PM -  6:28PM |    8.07 |
    +-----------+----------------+--------------------------------------+---------+
    |           |                |                        Weekly Total: |    8.07 |
    +-----------+----------------+--------------------------------------+---------+
    |           |                |                               Total: |   47.32 |
    +-----------+----------------+--------------------------------------+---------+

## Contributing

1. Fork it (https://github.com/bspaulding/timesheets/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
