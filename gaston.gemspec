# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'gaston/version'

Gem::Specification.new do |s|
  s.name         = "gaston"
  s.version      = Gaston::VERSION
  s.authors      = ["chatgris"]
  s.email        = "jboyer@af83.com"
  s.homepage     = "https://github.com/chatgris/gaston"
  s.summary      = "Dead simple Ruby config store."
  s.description  = "Dead simple Ruby config store."
  s.files        = `git ls-files README.md lib LICENSE`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.add_development_dependency "rspec", "~>2.8"
end
