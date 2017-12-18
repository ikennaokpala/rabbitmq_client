# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'black_panther/version'

Gem::Specification.new do |spec|
  spec.name          = 'black_panther'
  spec.version       = BlackPanther::VERSION
  spec.date          = '2017-12-13'
  spec.summary       = 'Black Panther'
  spec.description   = 'Transfers structured messages through a message queue.'
  spec.authors       = ['Paul Trippett', 'Ikenna N. Okpala']
  spec.email         = ['paul.trippett@tuskerdirect.com', 'ikenna.okpala@tuskerdirect.com']
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  spec.require_paths = ['lib']
  spec.homepage      = 'http://www.tuskerdirect.com'
  spec.required_ruby_version = '>= 2.2.5'

  spec.add_runtime_dependency 'google-protobuf'
  spec.add_runtime_dependency 'protobuf', '~> 3.6'
  spec.add_runtime_dependency 'bunny', '~> 2.7.2'
end
