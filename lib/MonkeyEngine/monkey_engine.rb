# frozen_string_literal: true

require 'observer'
require 'singleton'
require 'time'

require 'MonkeyActions'
require_relative 'action_rules'

module MonkeyEngine
  # Assigns, executes and evaluates actions.
  class Engine
    include Singleton
    include Observable

    # Evaluates whether or not the action is completed.
    def action_eval!(action)
      ActionRules.instance.action_eval! action
    end

    def do_action(action)
      if action.action_completed?
        raise MonkeyEngine::Exceptions::InvalidOperationException,
          "The action [#{action.class.name}] for Monkey [#{action.monkey.monkey_symbol}] is already completed"
      end

      do_action_type(action) if action.is_a? MonkeyActionType

      # TODO: Update database for monkey with action detail
      # TODO: Call observer to notify of action update.
      # TODO: Set action.action_completed to true if the action is completed.

      action.action_completed?
    end

    def do_action_type(action)
      action.action_completed = true
    end

    # Returns a new action.
    def new_action(monkey)
      unless monkey.action.nil? || monkey.action.action_completed?
        raise MonkeyEngine::Exceptions::InvalidOperationException,
          "The action [#{monkey.action.class.name}] for Monkey [#{monkey.monkey_symbol}] must be completed before calling new_action"
      end

      ActionRules.instance.get_next_action monkey
    end
  end
end
