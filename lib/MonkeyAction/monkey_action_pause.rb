require 'time'

require_relative 'monkey_action'
require_relative 'monkey_timed_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  pause (as in take a break)
# The monkey paused, usually from typing.
class MonkeyActionPause < MonkeyTimedAction

  WEIGHT = 2.0
  VALID_VALUES = (0..60) # Seconds (0 - 60 seconds)

  def initialize(monkey, value)
    super monkey, value, WEIGHT

    @action_time_of_completion = @action_time + value

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