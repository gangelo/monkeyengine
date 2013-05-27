require 'MonkeyAction/monkey_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  dead (as in not alive)
# The monkey has been killed - the thread is not running.
class MonkeyActionDead < MonkeyAction

  WEIGHT = 100.0
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