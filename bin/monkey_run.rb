require '../lib/MonkeyFactory'
require '../lib/MonkeyEngine'

runtime = ARGV[0]

monkey_service = MonkeyEngine::MonkeyService.instance

module Runner

  class MonkeyRun
    attr_reader :monkey_service, :runtime, :thread

    def initialize(monkey_service, runtime)
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
      puts "Time: [#{time}], Action: [#{action}], Param: [#{param}]"
    end

  end

end

monkey_run = Runner::MonkeyRun.new monkey_service, runtime
monkey_run.thread.join

monkey_service.kill_all!
monkey_service.join_all(10)
