require 'Monkey/monkey'
require 'MonkeyEngine/engine'
require 'MonkeyManager/monkey_manager'
require 'singleton'
require 'observer'
require 'forwardable'

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
      @monkey_manager.add(monkey)

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
  end

end