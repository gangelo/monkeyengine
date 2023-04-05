# frozen_string_literal: true

require 'English'

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'MonkeyEngine/version'

Gem::Specification.new do |spec|
  spec.name          = 'MonkeyEngine'
  spec.version       = MonkeyEngine::VERSION
  spec.authors       = ['Gene M. Angelo, Jr.']
  spec.email         = ['public.gma@gmail.com']
  spec.description   = "Have some fun! MonkeyEngine is a gem that allows virtual monkeys to tap away on a virtual keyboard! Can any of them complete a sentence? write a book? The sky's the limit! Add your own AI! Publish the results! Go...BANANAS!"
  spec.summary       = 'The engine that drives my monkeys!'
  spec.homepage      = 'https://github.com/gangelo/monkeyengine'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.3', '>= 2.3.20'
  spec.add_development_dependency 'colorize', '~> 0.8.1'
  spec.add_development_dependency 'pry-byebug', '~> 3.9'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.6'
  spec.add_development_dependency 'redcarpet', '>= 2.3.0', '~> 3.6'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'yard', '~> 0.9.28'

  spec.add_runtime_dependency 'LittleWeasel', '~> 5.0', '>= 5.0.3'
  spec.add_runtime_dependency 'ProtectedConstructor', '~> 2.0', '>= 2.0.3'
end
