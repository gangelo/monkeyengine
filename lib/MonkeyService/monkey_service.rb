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
    # @note Observers are notified after this operation in the form of these update method params:
    #  ObserverKlass#update(param1, param2, param3); where param1=Time of the operation,
    #  param2=Symbol representing the operation (in this case, :add), param3=The following Hash:
    #  {monkey: [monkey]} where monkey=The Monkey added.
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
    # @note The Monkey#monkey_do method executed continually by Monkey#thread is
    #  terminated.
    #
    # @note Observers are notified after this operation in the form of these update method params:
    #  ObserverKlass#update(param1, param2, param3); where param1=Time of the operation,
    #  param2=Symbol representing the operation (in this case, :kill!), param3=The following Hash:
    #  {monkey: [monkey]} where monkey=The Monkey killed.
    #
    def kill!(monkey)
      @monkey_manager.kill!(monkey)
      do_notify_observers(:kill!, {monkey: monkey})
    end

    # Kills all monkeys managed by the underlying MonkeyManager.
    #
    # @note The Monkey#monkey_do method executed continually by Monkey#thread, for each Monkey is
    #  terminated.
    #
    # @note Observers are notified after this operation in the form of these update method params:
    #  ObserverKlass#update(param1, param2, param3); where param1=Time of the operation,
    #  param2=Symbol representing the operation (in this case, :kill_all!), param3=nil.
    #
    def kill_all!
      @monkey_manager.kill_all!
      do_notify_observers(:kill_all!, nil)
    end

    def new_action(monkey)
      @engine.new_action monkey
    end

    # Performs the action against the Monkey associated with this action.
    #
    # @param [MonkeyActionDead, MonkeyActionEat, MonkeyActionPause, MonkeyActionSleep, MonkeyActionType, MonkeyActionWake, etc., #read/#write]
    #  action the action to apply against the Monkey associated with this action.
    #
    # @note Observers are notified after this operation in the form of these update method params:
    #  ObserverKlass#update(param1, param2, param3); where param1=Time of the operation,
    #  param2=Symbol representing the operation (in this case, :action_complete), param3=The following Hash:
    #  {action: [action]} where action=The action that was completed.
    #
    # @return (Boolean) true if the action performed has been completed (Action#action_completed?), false otherwise.
    #
    def monkey_do(action)
      do_notify_observers(:action_completed, {action: action}) if @engine.do_action action
    end

    # Evaluates the given action, to determine whether or not the action is completed (Action#action_completed?).
    #
    # @param [MonkeyActionDead, MonkeyActionEat, MonkeyActionPause, MonkeyActionSleep, MonkeyActionType, MonkeyActionWake, etc., #read]
    #  action the action to interrogate as to whether or not it is completed (Action#action_completed?).
    #
    # @return (Boolean) true if the action is completed (Action#action_completed?), false otherwise.
    #
    def action_eval!(action)
      @engine.action_eval! action
    end

    private

    # Notifies all observers.
    #
    def do_notify_observers(param1, param2)
      changed
      notify_observers(Time.now, param1, param2)
    end

  end

end