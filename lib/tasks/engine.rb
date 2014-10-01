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
      @monkey_service.add(MonkeyFactory::create :harpo)
      @monkey_service.add(MonkeyFactory::create :chico)
      @monkey_service.add(MonkeyFactory::create :zeppo)
    end

    def update(time, action, param)
      begin

        return unless param.is_a?(Hash) && param.has_key?(:action)

        if param[:action].is_a?(MonkeyActionType) && action == :action_completed
        
          monkey = param[:action].monkey.monkey_symbol.to_s
          is_word = param[:action].keyboard_input.is_word
          word = param[:action].keyboard_input.input_to_s

          #if param[:action].is_a?(MonkeyActionType) && action == :action_completed
            puts "Monkey: [#{monkey.capitalize}] | Is Word: [#{is_word}] | Value: [#{word.capitalize}]"
          #end

          if is_word
            @words << { word: word, monkey: monkey }
          end
        end
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

    puts "Total valid words: #{runner.words.count}"

    runner.words.sort!{|a,b| a[:monkey]<=>b[:monkey]}

    runner.words.each { |word|
      puts "Monkey [#{word[:monkey].capitalize}] typed [#{word[:word].capitalize}]"
    }
  end
end


