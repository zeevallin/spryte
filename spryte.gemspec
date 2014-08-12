# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spryte/version'

Gem::Specification.new do |spec|

  spec.name          = "spryte"

  spec.version       = Spryte::VERSION

  spec.authors       = ["Philip Vieira"]
  spec.email         = ["philip@chatspry.com"]

  spec.summary       = %q{API builder tools for Ruby on Rails}
  spec.description   = %q{API builder tools for Ruby on Rails}

  spec.homepage      = "https://github.com/chatspry/spryte"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

end
