# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "frakzio/version"

Gem::Specification.new do |s|
  s.name        = "frakzio"
  s.version     = Frakzio::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Adam Lipka, Piotr Dębosz"]
  s.email       = ["adam.lipka@gmail.com, piotr.debosz@gmail.com"]
  s.homepage    = ""
  s.summary     = "%Write a gem summary"
  s.description = "%Write a gem description"

  s.rubyforge_project = "frakzio"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
