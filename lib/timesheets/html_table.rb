module Timesheets
  class HTMLTable
    def initialize(options, &block)
      @heading = options[:headings]
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
      [
        "<html><head><style>#{@styles.join}</style></head><body><table class='timesheets-summary-table'><thead>",
        @heading.map {|cell| "<th>#{cell}</th>" },
	"</thead><tbody>",
        @rows.map {|row|
          if row == :separator
            "<tr><td colspan=#{@heading.length}><hr></td></tr>"
          else
            ["<tr>", row.map {|cell| "<td>#{cell}</td>" }.join, "</tr>"]
          end
        }.join,
	"</tbody></table></body></html>"
      ].join
    end
  end
end
