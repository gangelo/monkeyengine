require 'time'

require 'MonkeyAction/monkey_action_eat'
require 'MonkeyAction/monkey_action_pause'
require 'MonkeyAction/monkey_action_sleep'
require 'MonkeyAction/monkey_action_type'
require 'MonkeyAction/monkey_action_wake'

class ActionRules
  attr_accessor :monkey

  def initialize(monkey)
    raise MonkeyEngine::Exceptions::InvalidOperationException.new \
        "The action [#{monkey.action.class.name}] for Monkey [#{monkey.monkey_symbol}] is already completed" \
          if !monkey.action.nil? && monkey.action.action_completed?

    @monkey = monkey
  end

  # Gets the next action
  def get_next_action
    current_action = @monkey.action

    # If the monkey is sleeping, or first action, wake him up.
    return MonkeyActionWake.new(@monkey) if @monkey.action.nil? || @monkey.action.is_a?(MonkeyActionSleep)

    # Nothing else interesting, pause...
    #MonkeyActionPause.new(@monkey, Random.new.rand(MonkeyActionPause::VALID_VALUES))
    MonkeyActionPause.new(@monkey, 5)
  end

end