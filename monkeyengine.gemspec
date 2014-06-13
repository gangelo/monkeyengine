# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'MonkeyEngine/version'

Gem::Specification.new do |spec|
  spec.name          = "MonkeyEngine"
  spec.version       = MonkeyEngine::VERSION
  spec.authors       = ["Gene M. Angelo, Jr."]
  spec.email         = ["public.gma@gmail.com"]
  spec.description   = %q{MonkeyEngine - FUN!}
  spec.summary       = %q{The engine that drives my monkeys!}
  spec.homepage      = "http://www.geneangelo.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 1.9.3'

  spec.add_runtime_dependency 'LittleWeasel', '~> 1.1.0'
  spec.add_runtime_dependency 'ProtectedConstructor', '~> 1.0.5'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "rspec", "~> 2.13.0"
  spec.add_development_dependency "yard", "0.8.6.2"
  spec.add_development_dependency "redcarpet", "~> 2.3.0"
end
