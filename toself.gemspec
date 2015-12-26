# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/version.rb'

Gem::Specification.new do |spec|
  spec.name          = "."
  spec.version       = Toself::VERSION
  spec.authors       = ["jonfm"]
  spec.email         = ["jon@jonfm.co.uk"]
  spec.summary       = %q{Pet project for CLI journaling & timetracking}
  spec.description   = %q{Pet project for CLI journaling & timetracking}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir.glob(".")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
end
