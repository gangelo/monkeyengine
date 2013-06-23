require 'observer'
require 'singleton'
require 'time'

require 'MonkeyEngine/action_rules'
require 'MonkeyAction/monkey_action_eat'
require 'MonkeyAction/monkey_action_pause'
require 'MonkeyAction/monkey_action_sleep'
require 'MonkeyAction/monkey_action_type'
require 'MonkeyAction/monkey_action_wake'
require 'MonkeyAction/monkey_action_dead'

module MonkeyEngine

  # Assigns, executes and evaluates actions.
  class Engine
    include Singleton
    include Observable

    private
    def initialize
    end

    public

    def action_eval!(action)
      ActionRules.instance.action_eval! action
    end

    def do_action(action)
      raise MonkeyEngine::Exceptions::InvalidOperationException.new \
        "The action [#{action.class.name}] for Monkey [#{action.monkey.monkey_symbol}] is already completed" if action.action_completed?

      do_action_type(action) if action.is_a? MonkeyActionType

      # TODO: Update database for monkey with action detail
      # TODO: Call observer to notify of action update.
      # TODO: Set action.action_completed to true if the action is completed.

      action.action_completed?
    end

    def do_action_type(action)

    end

    # Returns a new action.
    def new_action(monkey)
      raise MonkeyEngine::Exceptions::InvalidOperationException.new \
        "The action [#{monkey.action.class.name}] for Monkey [#{monkey.monkey_symbol}] must be completed before calling new_action" \
          unless monkey.action.nil? || monkey.action.action_completed?

      return ActionRules.instance.get_next_action monkey
    end

  end
end
