# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reuters/version'

Gem::Specification.new do |spec|

  # Only with >= Ruby 2
  spec.required_ruby_version = '>= 2.0.0'

  spec.name          = "reuters"
  spec.version       = Reuters::VERSION
  spec.authors       = ['Stockflare']
  spec.email         = ['info@stockflare.com']
  spec.summary       = %q(Ruby client for Thomson Reuters Knowledge Direct (TRKD) API)
  spec.description   = %q(Ruby Gem for interacting with the Thomson Reuters Knowledge Direct API)
  spec.homepage      = 'https://github.com/stockflare/reuters'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency "savon", "~> 2.5.1"
  spec.add_dependency "wasabi", "3.3.0"
  spec.add_dependency "activesupport"

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.0'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'redcarpet'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'

end
