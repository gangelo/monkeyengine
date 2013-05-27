require 'MonkeyAction/monkey_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  type (as in keyboard)
# The monkey typed something on the keyboard.
class MonkeyActionType < MonkeyAction

  WEIGHT = 5.0

  def initialize(monkey, value)
    super monkey, value, WEIGHT

    validate

    self
  end

  protected
  def validate
    raise MonkeyEngine::Exceptions::NilArgumentException.new "Value '#{value}' cannot be nil"  \
      if @value.nil?

    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "Value '#{value}' is not a valid argument type"  \
      unless @value.is_a?(String)

    raise MonkeyEngine::Exceptions::InvalidArgumentValueException.new "Value '#{value}' is not a valid value"  \
      if @value.empty?
  end
end