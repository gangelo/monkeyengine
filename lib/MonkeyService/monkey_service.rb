require 'singleton'
require 'observer'
require 'forwardable'

require 'Monkey'
require 'MonkeyEngine'
require 'MonkeyManager'

module MonkeyEngine

  # The monkey service.
  #
  # Provides the main interface for all functionality relating to
  # the MonkeyEngine (see MonkeyEngine) and this gem.
  #
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

    # Adds the Monkey to be managed.
    #
    # @param [Monkey, #read] monkey the Monkey to add.
    #
    def add(monkey)
      @monkey_manager.add(monkey).start
      do_notify_observers(:add, {monkey: monkey})
    end

    # Determines if any Monkeys that are being managed by the
    # underlining MonkeyManager are alive.
    #
    # @note A Monkey is considered alive if the Monkey#thread.alive? is true.
    #
    # @return [Boolean] true if any Monkeys are alive, false otherwise.
    #
    def any_alive?
      return false if @monkey_manager.count == 0

      alive_count = 0

      @monkey_manager.each { |monkey| alive_count += 1 if monkey.alive? }

      alive_count > 0
    end

    # Kills the monkey.
    #
    # @param [Monkey, #read/#write] monkey the Monkey to kill.
    #
    def kill!(monkey)
      @monkey_manager.kill!(monkey)
      do_notify_observers(:kill!, {monkey: monkey})
    end

    # Kills all the monkeys.
    def kill_all!
      @monkey_manager.kill_all!
      do_notify_observers(:kill_all!, nil)
    end

    def new_action(monkey)
      @engine.new_action monkey
    end

    def monkey_do(action)
      do_notify_observers(:action_completed, {action: action}) if @engine.do_action action
    end

    def action_eval!(action)
      @engine.action_eval! action
    end

    private

    def do_notify_observers(param1, param2)
      changed
      notify_observers(Time.now, param1, param2)
    end

  end

end