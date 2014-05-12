# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reuters/version'

Gem::Specification.new do |spec|
  spec.name          = "reuters"
  spec.version       = Reuters::VERSION
  spec.authors       = ["Stockflare"]
  spec.email         = ["info@stockflare.com"]
  spec.summary       = %q{Ruby client for Thomson Reuters Knowledge Direct (TRKD) API}
  spec.description   = %q{Ruby Gem for interacting with the Thomson Reuters Knowledge Direct (TRKD) API}
  spec.homepage      = "https://github.com/stockflare/reuters"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "savon"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "redcarpet"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "codeclimate-test-reporter"
  spec.add_development_dependency "coveralls"

end
