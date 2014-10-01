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

  spec.required_ruby_version = '~> 2.1' #'~> 2.0', '>=2.1.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'
  spec.add_development_dependency 'yard', '0.8.6.2'
  spec.add_development_dependency 'redcarpet', '~> 2.3', '>= 2.3.0'
  spec.add_development_dependency 'pry', '~> 0.10.1'

  spec.add_runtime_dependency 'LittleWeasel', '~> 3.0' #, '>= 3.0.0'
  spec.add_runtime_dependency 'ProtectedConstructor', '~> 2.0', '>=2.0.0'
end
