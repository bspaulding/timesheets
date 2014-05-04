# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'timesheets/version'

Gem::Specification.new do |spec|
  spec.name          = "timesheets"
  spec.version       = Timesheets::VERSION
  spec.authors       = ["Bradley J. Spaulding"]
  spec.email         = ["brad.spaulding@gmail.com"]
  spec.summary       = %q{A CLI for managing timesheets.}
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "terminal-table"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "simplecov"
end
