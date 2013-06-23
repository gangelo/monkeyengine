require 'time'

require_relative 'monkey_action'
require_relative 'monkey_timed_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  eat (as in banana)
# The monkey is eating.
class MonkeyActionEat < MonkeyTimedAction

  WEIGHT = 2.0
  VALID_VALUES = (30..60) # 30 through 60 minutes

  def initialize(monkey, value)
    super monkey, value, WEIGHT

    @action_time_of_completion = @action_time + (value * 60)

    validate

    self
  end

  protected
  def validate
    super

    raise MonkeyEngine::Exceptions::InvalidArgumentValueException.new "Value '#{value}' is not a valid value"  \
      if !VALID_VALUES.include?(@value)
  end
end