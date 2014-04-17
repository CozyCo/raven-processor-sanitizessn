# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "raven-processor-sanitizessn"
  spec.version       = Raven::Processor::SanitizeSSNVersion::VERSION
  spec.authors       = ["Cozy Services Ltd.", "Matt Greensmith"]
  spec.email         = ["opensource@cozy.co"]
  spec.summary       = %q{A processor plugin for the Sentry Raven gem that sanitizes Social Security Number fields.}
  spec.homepage      = "http://github.com/cozyco/raven-processor-sanitizessn"
  spec.license       = "Apache"
  spec.files         = Dir['lib/**/*']
  spec.require_paths = ["lib"]
  spec.add_dependency 'sentry-raven', '~> 0.4'

end
