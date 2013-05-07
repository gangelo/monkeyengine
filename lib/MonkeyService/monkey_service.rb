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

    def_delegators :@monkey_manager, :add, :alive?, :get, :count, :exists?, :join_all, :kill_all!

    def initialize
      @monkey_manager = MonkeyEngine::MonkeyManager.instance
      @monkey_manager.add(Monkey.new :groucho)
      @monkey_manager.add(Monkey.new :harpo)
      @monkey_manager.add(Monkey.new :chico)

      @engine = MonkeyEngine::Engine.instance
    end

    #def add(monkey)
    #  @monkey_manager.add(monkey)
    #end

    #def count
    #  @monkey_manager.count
    #end

    #def exists?(monkey)
    #  @monkey_manager.exists? monkey
    #end

    #def alive?(monkey)
    #  @monkey_manager.alive? monkey
    #end

    def any_alive?
      return false if @monkey_manager.count == 0

      alive_count = 0

      @monkey_manager.each { |monkey| ++alive_count if monkey.alive? }

      alive_count
    end

    # Starts all the monkeys
    def start_all
    end

    #def join_all(limit=nil)
    #  @monkey_manager.join_all limit
    #end

    # Kills all the monkeys.
    #def kill_all
      # Not delegating to @monkey_manager because kill_all! (bang)
      # is somewhat misleading as  this object is not directly altered.
    #  @monkey_manager.kill_all!
    #end

    # Perform a monkey action.
    #def monkey_do(monkey, action)
    #end
  end

end