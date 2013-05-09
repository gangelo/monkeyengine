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

    #def alive?(monkey)
    #  @monkey_manager.alive? monkey
    #end

    def any_alive?
      return false if @monkey_manager.count == 0

      alive_count = 0

      @monkey_manager.each { |monkey| ++alive_count if monkey.alive? }

      alive_count
    end

    #def count
    #  @monkey_manager.count
    #end

    #def exists?(monkey)
    #  @monkey_manager.exists? monkey
    #end

    # Starts all the monkeys
    #def start_all
    #end

    #def join_all(limit=nil)
    #  @monkey_manager.join_all limit
    #end

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

    # Perform a monkey action.
    #def monkey_do(monkey, action)
    #end
  end

end