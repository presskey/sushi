# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'sushi/version'

Gem::Specification.new do |s|
  s.name        = 'sushi'
  s.version     = Sushi::VERSION.dup
  s.summary     = 'Capistrano SSH recipe.'
  s.description = 'Capistrano SSH recipe that starts a SSH connection to remote server.'
  s.author      = 'presskey'
  s.email       = 'hello.from.code@gmail.com'
  s.homepage    = 'http://github.com/presskey/sushi'
  s.license 	= 'MIT'
  
  s.files       = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end