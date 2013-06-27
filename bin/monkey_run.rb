require 'LittleWeasel'
require '../lib/MonkeyFactory'
require '../lib/MonkeyEngine'

runtime = ARGV[0]

monkey_service = MonkeyEngine::MonkeyService.instance

LittleWeasel::Checker.instance.options = {exclude_alphabet: true}

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

    protected

    def go
      @monkey_service.add(MonkeyFactory::create :groucho)
    end

    def update(time, action, param)
      begin

        if param[:action].is_a?(MonkeyActionType) && action == :action_completed
          puts "Is Word: [#{param[:action].keyboard_input.is_word}] | Value: [#{param[:action].keyboard_input.input_to_s}]"
        end

        if param[:action].keyboard_input.is_word
          @words.push param[:action].keyboard_input.input_to_s
        end
      rescue Exception => e
      end
    end

  end

end

monkey_run = Runner::MonkeyRun.new monkey_service, runtime
monkey_run.thread.join

monkey_service.kill_all!
monkey_service.join_all(10)

puts "Total words: #{monkey_run.words.count}"
monkey_run.words.each { |word|
  puts word
}


