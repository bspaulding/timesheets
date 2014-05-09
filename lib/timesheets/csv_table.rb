module Timesheets
  class CSVTable
    def initialize(options, &block)
      @heading = options[:headings]
      @rows = []
      block.call(self)
    end

    def <<(row)
      @rows << row unless row == :separator
    end

    def align_column(n, alignment)
    end

    def to_s
      ([@heading] + @rows).map {|row| row.map {|cell| "\"#{cell}\"" }.join(",") }.join("\n")
    end
  end
end
