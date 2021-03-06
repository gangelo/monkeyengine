require 'time'

require_relative 'monkey_action'
require_relative 'monkey_timed_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  sleep (as in take a snooze)
# The monkey is a sleep.
class MonkeyActionSleep < MonkeyTimedAction

  WEIGHT = 10.0
  VALID_VALUES = ((60 * 6)..(60 * 8)) # 6 through 8 hours

  def initialize(monkey, value)
    super monkey, value, WEIGHT

    @action_time_of_completion = @action_time + (value * (60 * 60))

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