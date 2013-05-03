require 'MonkeyAction/monkey_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  one that is timed based on an Integer.
class MonkeyTimedAction
  include MonkeyAction

  def initialize(monkey, value, weight)
    @monkey = monkey
    @value = value
    @weight = weight

    validate
  end

  protected
  def validate
    raise MonkeyEngine::Exceptions::NilArgumentException.new "Value '#{value}' cannot be nil"  \
      if @value.nil?

    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "Value '#{value}' is not a valid argument type"  \
      unless @value.is_a?(Integer)
  end
end