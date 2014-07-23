# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guachiman/rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'guachiman-rails'
  spec.version       = Guachiman::Rails::VERSION
  spec.authors       = ['Francesco Rodriguez', 'Gustavo Beathyate']
  spec.email         = ['lrodriguezsanc@gmail.com', 'gustavo.bt@me.com']
  spec.summary       = 'Rails specific implementation of the Guachiman gem'
  spec.description   = "#{ spec.summary } for authorization purposes"
  spec.homepage      = 'https://github.com/goddamnhippie/guachiman-rails'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'guachiman', '~> 1.0', '>= 1.0.0'
  spec.add_dependency 'railties',  '~> 4.0', '>= 4.0.0'

  spec.add_development_dependency 'rake',     '~> 10.3', '>= 10.3.0'
  spec.add_development_dependency 'minitest', '~>  5.3', '>=  5.3.3'
  spec.add_development_dependency 'bundler',  '~>  1.6', '>=  1.6.0'
end
