require_relative 'monkey_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  type (as in keyboard)
# The monkey typed something on the keyboard.
class MonkeyActionType < MonkeyAction

  attr_reader :keyboard_input

  WEIGHT = 5.0

  def initialize(monkey, keyboard_input)
    raise MonkeyEngine::Exceptions::NilArgumentException.new "keyboard_input '#{keyboard_input}' cannot be nil"  \
      if keyboard_input.nil?

    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "keyboard_input '#{keyboard_input}' is not a valid argument type"  \
      unless keyboard_input.is_a?(KeyboardInput)

    @keyboard_input = keyboard_input

    super monkey, @keyboard_input.input, WEIGHT

    validate

    self
  end

  protected
  def validate

    raise MonkeyEngine::Exceptions::NilArgumentException.new "Value '#{value}' cannot be nil"  \
      if @value.nil?

    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "Value '#{value}' is not a valid argument type"  \
      unless @value.is_a?(Array)

    raise MonkeyEngine::Exceptions::InvalidArgumentValueException.new "Value '#{value}' cannot be empty"  \
      if @value.empty?
  end
end