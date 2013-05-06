require 'Monkey/monkey'
require 'MonkeyEngine/engine'
require 'singleton'

module MonkeyService
  include Singleton

  def initialize
    @monkey_manager = MonkeyEngine::MonkeyManager.instance
    @monkey_manager.add(Monkey.new :groucho)
    @monkey_manager.add(Monkey.new :harpo)
    @monkey_manager.add(Monkey.new :chico)

    @engine = MonkeyEngine::Engine.instance
  end

  def add(monkey)
    @monkey_manager.add(monkey) unless @monkey_manager.exists_by_name? monkey.monkey_name
  end

  # Starts all the monkeys
  def start_all
  end

  def join_all(limit=nil)
    @monkey_manager.join_all limit
  end

  # Kills all the monkeys.
  def kill_all
    @monkey_manager.kill_all!
  end

  # Perform a monkey action.
  #def monkey_do(monkey, action)
  #end
end