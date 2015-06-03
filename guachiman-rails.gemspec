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
  spec.description   = "#{ spec.summary } for authorization in ActionController"
  spec.homepage      = 'https://github.com/goddamnhippie/guachiman-rails'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'guachiman', '~> 2.0', '>= 2.0.0'
  spec.add_dependency 'railties',  '~> 4.2', '>= 4.2.0'

  spec.add_development_dependency 'rake',     '~> 10.4', '>= 10.4.0'
  spec.add_development_dependency 'minitest', '~>  5.7', '>=  5.7.0'
  spec.add_development_dependency 'bundler',  '~>  1.9', '>=  1.9.0'
end
