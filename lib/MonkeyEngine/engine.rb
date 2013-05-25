require 'observer'
require 'singleton'
require 'time'

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
        "The action [#{action.class.name}] for Monkey [#{action.monkey.monkey_symbol}] is already completed" if action.action_completed

      # TODO: Update database for monkey with action detail
      # TODO: Call observer to notify of action update.
      # TODO: Set action.action_completed to true if the action is completed.

      action.action_completed
    end

    def get_action(monkey)
      MonkeyActionPause.new monkey, 5
    end

    def action_eval!(action)
      # Evaluates an action and sets it to completed if he action is completed.

      action.action_completed = true if action.is_a?(MonkeyActionPause) && action.action_time_of_completion <= Time.now

      action.action_completed
    end
  end
end
