# frozen_string_literal: true

require 'pry-byebug'
require 'colorize'
require 'yaml'
require 'minitest/autorun'
require 'LittleWeasel'

require File.expand_path('../MonkeyFactory', __dir__)
require File.expand_path('../MonkeyEngine', __dir__)

LittleWeasel.configure { |config| }

module Runner
  class MonkeyRun
    attr_reader :monkey_service, :runtime, :thread, :monkey_words

    def initialize(monkey_service, runtime)
      @monkey_words = {}
      @monkey_service = monkey_service
      @runtime = runtime.to_i

      @monkey_service.add_observer self

      @thread = Thread.new do
        go
        sleep @runtime
      end
    end

    def go
      @monkey_service.add(MonkeyFactory.create(:groucho))
      @monkey_service.add(MonkeyFactory.create(:harpo))
      @monkey_service.add(MonkeyFactory.create(:chico))
      @monkey_service.add(MonkeyFactory.create(:zeppo))
    end

    def update(_time, action, param)
      return unless param.is_a?(Hash) && param.key?(:action)

      if param[:action].is_a?(MonkeyActionType) && action == :action_completed
        monkey = param[:action].monkey.monkey_symbol.to_s
        is_word = param[:action].keyboard_input.is_word
        word = param[:action].keyboard_input.input_to_s

        message = "Monkey: [#{monkey.capitalize}] | Is Word: [#{is_word}] | Value: [#{word.capitalize}]"
        if is_word
          @monkey_words[monkey] = {} unless @monkey_words[monkey]
          @monkey_words[monkey][word] = 0 unless @monkey_words.dig(monkey, word)
          times = @monkey_words[monkey][word] += 1
          puts "#{message} | Times: #{times} so far!".colorize(color: :green, mode: :bold)
          return
        end

        puts message
      end
    rescue StandardError => e
      puts "StandardError: #{e}"
    end
  end
end

namespace :engine do
  desc 'Run the MonkeyEngine'
  task :run do
    runtime = 30

    service = MonkeyEngine::MonkeyService.instance

    runner = Runner::MonkeyRun.new service, runtime
    runner.thread.join

    service.kill_all!
    service.join_all(10)
    sleep(3)

    monkey_words_sorted = runner.monkey_words.sort_by { |key, _value| key }

    puts '-----------------------------------------'
    puts 'Valid words:'

    word_index = 0

    monkey_words_sorted.each do |monkey_word_info|
      monkey = monkey_word_info[0]
      monkey_word_info[1].each do |monkey_word|
        word_index += 1
        word = monkey_word[0]
        times = monkey_word[1]
        if word.length > 1
          puts "#{word_index}. Monkey [#{monkey.capitalize}] typed [#{word.capitalize}] [#{times}] time(s) " \
               "<=== #{word.length}-letter word!".colorize(
                 color: :green, mode: :bold
               )
        else
          puts "#{word_index}. Monkey [#{monkey.capitalize}] typed [#{word.capitalize}] [#{times}] time(s)"
            .colorize(color: :green)
        end
      end
    end
    total_valid_words_count = runner.monkey_words.inject(0) do |sum, monkey_word_info|
      sum + monkey_word_info[1].keys.count
    end

    puts '-----------------------------------------'
    puts "Total valid words: #{total_valid_words_count}"
    puts 'These monkeys can type!' if total_valid_words_count.positive?
    puts 'Done.'
    puts
    puts
  end
end
