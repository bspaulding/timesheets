# Timesheets

A CLI for managing timesheets.

## Installation

Install it via RubyGems:

    $ gem install timesheets

## Usage

### Help / Commands

Run `timesheets` to see a list of available commands:

    $ timesheets
    Commands:
      timesheets help [COMMAND]  # Describe available commands or one specific command
      timesheets summary         # See a summary table of time worked


### Summary

A neat ASCII table report, including total hours.

    +-----------+----------------+------------+----------+---------+
    | Weekday   | Date           | Start Time | End Time | Hour(s) |
    +-----------+----------------+------------+----------+---------+
    |    Monday | April 28, 2014 |    12:00PM |   8:00PM |     8.0 |
    |    Monday | April 28, 2014 |    11:00AM |   8:00PM |     9.0 |
    |   Tuesday | April 29, 2014 |    11:00AM |   2:00PM |     3.0 |
    |   Tuesday | April 29, 2014 |     2:30PM |   8:30PM |     6.0 |
    | Wednesday | April 30, 2014 |    11:00AM |   7:00PM |     8.0 |
    |  Thursday |   May  1, 2014 |    10:15AM |   6:45PM |     8.5 |
    |    Friday |   May  2, 2014 |    10:30AM |  12:30PM |     2.0 |
    |    Friday |   May  2, 2014 |     2:30PM |   7:15PM |    4.75 |
    +-----------+----------------+------------+----------+---------+
    |           |                |            |          |   49.25 |
    +-----------+----------------+------------+----------+---------+

### Start

Starts a session.

    $ timesheets start
    Started session at 2014-05-04 13:47:33 -0500

## Contributing

1. Fork it (https://github.com/bspaulding/timesheets/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
