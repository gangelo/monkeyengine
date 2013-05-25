require 'observer'
require 'singleton'
require 'time'

#require 'Action/action'
require 'MonkeyAction/monkey_action_eat'
require 'MonkeyAction/monkey_action_pause'
require 'MonkeyAction/monkey_action_sleep'
require 'MonkeyAction/monkey_action_type'
require "MonkeyEngine/version"

module MonkeyEngine

  # Engine class.
  class Engine
    include Singleton
    include Observable

    private
    def initialize
    end

    public

    def do_action(action)
      raise MonkeyEngine::Exceptions::InvalidOperationException.new \
        "The action [#{action.class.name}] for Monkey [#{action.monkey.monkey_symbol}] is already completed" if action.action_completed?

      # TODO: Update database for monkey with action detail
      # TODO: Call observer to notify of action update.
      # TODO: Set action.action_completed to true if the action is completed.

      action.action_completed?
    end

    def new_action(monkey)
      MonkeyActionPause.new monkey, 5
    end

    # Evaluates an action and sets it to completed if he action is completed.
    def action_eval!(action)
      raise MonkeyEngine::Exceptions::NilArgumentException.new "The [action] to be evaluated cannot be nil" \
        if action.nil?

      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? Action

      action_eval_eat(action) if action.is_a?(MonkeyActionEat)
      action_eval_pause(action) if action.is_a?(MonkeyActionPause)
      action_eval_sleep(action) if action.is_a?(MonkeyActionSleep)
      action_eval_type(action) if action.is_a?(MonkeyActionType)

      # If we don't specifically handle the action, just let it pass through - Action#action_completed will
      # be set elsewhere.
      action.action_completed?
    end

    private

    def action_eval_eat(action)
      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyActionEat

      action_eval_timed_action action
    end

    def action_eval_pause(action)
      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyActionPause

      action_eval_timed_action action
    end

    def action_eval_sleep(action)
      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyActionSleep

      action_eval_timed_action action
    end

    def action_eval_type(action)
      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyActionType

      # TODO: How do I evaluate this?

      action
    end

    def action_eval_timed_action(action)
      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyTimedAction

      action.action_completed = true if action.action_time_of_completion <= Time.now

      action
    end
  end
end
