# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/requestash/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-requestash"
  spec.version       = Rack::Requestash::VERSION
  spec.authors       = ["R. Tyler Croy"]
  spec.email         = ["rtyler.croy@lookout.com"]
  spec.description   = "A simple gem for overwriting outputting JSON formatted access logs from Rack apps"
  spec.summary       = "A simple gem for overwriting outputting JSON formatted access logs from Rack apps"
  spec.homepage      = "https://github.com/lookout/rack-requestash"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"

  spec.add_dependency 'rack'
  spec.add_dependency 'json'
end
