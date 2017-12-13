require_relative 'csv_reader/row_parser'

class CsvReader

  def initialize(csv)
    @csv = csv.map do |row|
      STDOUT.puts RowParser.call(row)
    end
  end
end
