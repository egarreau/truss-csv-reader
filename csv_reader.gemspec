lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "csv_reader/version"

Gem::Specification.new do |spec|
  spec.name          = "csv_reader"
  spec.author        = "Evangeline Garreau"
  spec.version       = CsvReader::VERSION

  spec.summary       = "A command line interface to parse a given CSV file."

  spec.bindir        = "bin"
  spec.executables   = ["csv_reader"]
  spec.require_paths = ["lib"]
end
