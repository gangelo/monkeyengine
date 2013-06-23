require_relative 'monkey_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  wake (as in from sleep)
# The monkey has awakened from sleep.
class MonkeyActionWake < MonkeyAction

  WEIGHT = 2.0
  VALID_VALUES = [ true ]

  def initialize(monkey)
    super monkey, true , WEIGHT

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