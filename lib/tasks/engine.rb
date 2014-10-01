require 'pry'

require 'yaml'
require "minitest/autorun"
require 'LittleWeasel'

require File.expand_path('../../MonkeyFactory', __FILE__)
require File.expand_path('../../MonkeyEngine', __FILE__)

module Runner
  
  class MonkeyRun
    attr_reader :monkey_service, :runtime, :thread, :words

    def initialize(monkey_service, runtime)
      @words = Array.new
      @monkey_service = monkey_service
      @runtime = runtime.to_i

      @monkey_service.add_observer self

      @thread = Thread.new {
        go
        sleep @runtime
      }

      self
    end

    #protected

    def go
      @monkey_service.add(MonkeyFactory::create :groucho)
    end

    def update(time, action, param)
      begin

        return unless param.is_a?(Hash) && param.has_key?(:action)

        if param[:action].is_a?(MonkeyActionType) && action == :action_completed
          puts "Monkey: [#{param[:action].monkey.monkey_symbol.to_s}] | Is Word: [#{param[:action].keyboard_input.is_word}] | Value: [#{param[:action].keyboard_input.input_to_s}]"
        end

        if param[:action].keyboard_input.is_word
          @words << param[:action].keyboard_input.input_to_s
        end

        if param[:action].keyboard_input.is_word
          #puts param[:action].to_yaml
        end

        #binding.pry
      rescue Exception => e
        puts "Exception: #{e}"
      end
    end
  end
end


namespace :engine do
  desc "Run the MonkeyEngine"
  task :run do
    runtime = 10 #ARGV[0]

    service = MonkeyEngine::MonkeyService.instance

    LittleWeasel::Checker.instance.options = {exclude_alphabet: true, strip_whitespace: false, ignore_numeric: false}

    runner = Runner::MonkeyRun.new service, runtime
    runner.thread.join

    service.kill_all!
    service.join_all(10)

    puts "Total words: #{runner.words.count}"
    runner.words.each { |word|
      puts word
    }
  end
end