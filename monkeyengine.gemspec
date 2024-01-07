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
  spec.description   = "Have some fun! MonkeyEngine is a gem that allows virtual monkeys " \
    "to tap away on a virtual keyboard! Can any of them complete a sentence? " \
    "write a book? The sky is the limit! Add your own AI! Publish the results! " \
    "Go...BANANAS!"
  spec.summary       = 'The engine that drives my monkeys!'
  spec.homepage      = 'https://github.com/gangelo/monkeyengine'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0.1', '< 4.0')

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'LittleWeasel', '~> 5.0'
  spec.add_runtime_dependency 'ProtectedConstructor', '~> 3.0'
  spec.post_install_message = <<~POST_INSTALL
    Thank you for installing MonkeyEngine.

    *** If you found this gem enjoyable, helpful or otherwise positive, please consider giving it a star on GitHub so I know this gem is worth maintaining ***

    This is a gem created for fun and demonstrates a little about ruby threads.

    Run `bundle exec rake engine:run` from your command line to see a sample.
  POST_INSTALL
end
