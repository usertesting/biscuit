# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'biscuit/version'

Gem::Specification.new do |spec|
  spec.name          = "biscuit"
  spec.version       = Biscuit::VERSION
  spec.authors       = ["Suan-Aik Yeo"]
  spec.email         = ["yeosuanaik@gmail.com"]

  spec.summary       = %q{Ruby wrapper for biscuit (https://github.com/dcoker/biscuit).}
  spec.description   = %q{Ruby wrapper for biscuit (https://github.com/dcoker/biscuit).}
  spec.homepage      = "https://github.com/usertesting/biscuit"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = 'biscuit'
  spec.require_paths = ["lib"]
  spec.extensions    = ["Rakefile"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "rake"
end
