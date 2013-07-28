# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'gaston/version'

Gem::Specification.new do |s|
  s.name         = "gaston"
  s.version      = Gaston::VERSION
  s.authors      = ["chatgris"]
  s.email        = "jboyer@af83.com"
  s.homepage     = "http://chatgris.github.com/Gaston"
  s.summary      = "Dead simple Ruby config store."
  s.description  = "Dead simple Ruby config store."
  s.license      = 'MIT'
  s.files        = `git ls-files README.md lib LICENSE`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.add_dependency "inflecto"
  s.add_development_dependency "rspec", "~>2.8"
  s.add_development_dependency "rake"
end
