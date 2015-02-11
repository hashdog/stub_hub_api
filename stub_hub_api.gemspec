# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stub_hub_api/version'

Gem::Specification.new do |spec|
  spec.name          = "stub_hub_api"
  spec.version       = StubHubApi::VERSION
  spec.authors       = ["chebyte"]
  spec.email         = ["mauro@hashdog.com"]
  spec.summary       = %q{Gem for StubHub}
  spec.description   = %q{This gem provides access to add, edit and delete listings appearing on StubHub.}
  spec.homepage      = "http://hashdog.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_runtime_dependency 'nokogiri', '1.6.3.1', '= 1.6.3.1'
  spec.add_runtime_dependency 'faraday', '~> 0.9', '>= 0.9.0'
  spec.add_runtime_dependency 'json', '~> 1.8.1', '>= 1.8.1'
end
