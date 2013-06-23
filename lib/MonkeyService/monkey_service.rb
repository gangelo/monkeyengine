require 'singleton'
require 'observer'
require 'forwardable'

require 'Monkey'
require 'MonkeyEngine'
require 'MonkeyManager'

module MonkeyEngine

  # The monkey service.
  class MonkeyService
    include Singleton
    include Observable
    include Enumerable
    extend Forwardable

    def_delegators :@monkey_manager, :alive?, :get, :count, :exists?, :join_all

    def initialize
      @monkey_manager = MonkeyEngine::MonkeyManager.instance
      @engine = MonkeyEngine::Engine.instance
    end

    def add(monkey)
      @monkey_manager.add(monkey).start

      changed
      notify_observers(Time.now, :add, {monkey: monkey})
    end

    def any_alive?
      return false if @monkey_manager.count == 0

      alive_count = 0

      @monkey_manager.each { |monkey| alive_count += 1 if monkey.alive? }

      alive_count > 0
    end

    def kill!(monkey)
      @monkey_manager.kill!(monkey)

      changed
      notify_observers(Time.now, :kill!, monkey)
    end

    # Kills all the monkeys.
    def kill_all!
      @monkey_manager.kill_all!

      changed
      notify_observers(Time.now, :kill_all!, nil)
    end

    def new_action(monkey)
      @engine.new_action monkey
    end

    def monkey_do(action)
      @engine.do_action action
    end

    def action_eval!(action)
      @engine.action_eval! action
    end
  end

end