require 'digest'

module Timesheets
  class HTMLTable
    def initialize(options, &block)
      @heading = options[:headings]
      @template = options[:template]
      @rows = []
      @styles = ["table.timesheets-summary-table th { text-align: left; }"]
      block.call(self)
    end

    def <<(row)
      @rows << row
    end

    def align_column(n, alignment)
      @styles << "table.timesheets-summary-table td:nth-child(#{n+1}) { text-align: #{alignment}; }"
    end

    def to_s
			styles = @styles.join
			table = [
        "<table class='timesheets-summary-table'><thead>",
        @heading.map {|cell| "<th>#{cell}</th>" },
				"</thead><tbody>",
        @rows.map {|row|
          if row == :separator
						""
          else
            ["<tr>", row.map {|cell| "<td>#{cell}</td>" }.join, "</tr>"]
          end
        }.join,
				"</tbody></table>"
      ].join

			template
				.gsub("{{styles}}", styles)
				.gsub("{{table}}", table)
				.gsub("{{today}}", Time.new.strftime('%Y-%m-%d'))
				.gsub("{{invoiceID}}", (Digest::SHA2.new << template << Time.new.to_i.to_s).to_s[0...8])
				.gsub("{{firstDayNice}}", @rows.first[1])
    end

		private

		def template
			@template ? File.read(@template) : default_template
		end

		def default_template
<<-TEMPLATE
<!DOCTYPE html>
<html>
<head>
	<style>
		{{styles}}
	</style>
</head>
<body>
	<h1>Invoice <small>for the week of {{firstDayNice}}</h1>
	<p>
		<strong>Date:</strong><br/>
		{{today}}
	</p>
	<p>
		<strong>Invoice ID:</strong><br/>
		{{invoiceID}}
	</p>
	{{table}}
</body>
</html>
TEMPLATE
		end
  end
end
