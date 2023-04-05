# frozen_string_literal: true

require_relative 'monkey_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  type (as in keyboard)
# The monkey typed something on the keyboard.
class MonkeyActionType < MonkeyAction
  attr_reader :keyboard_input

  WEIGHT = 5.0

  def initialize(monkey, keyboard_input)
    raise MonkeyEngine::Exceptions::NilArgumentException, "keyboard_input '#{keyboard_input}' cannot be nil"  \
      if keyboard_input.nil?

    unless keyboard_input.is_a?(KeyboardInput)
      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException,
            "keyboard_input '#{keyboard_input}' is not a valid argument type"
    end

    @keyboard_input = keyboard_input

    super monkey, @keyboard_input.input, WEIGHT

    validate

    self
  end

  protected

  def validate
    raise MonkeyEngine::Exceptions::NilArgumentException, "Value '#{value}' cannot be nil"  \
      if @value.nil?

    unless @value.is_a?(Array)
      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException,
            "Value '#{value}' is not a valid argument type (#{value.class.name})"
    end

    raise MonkeyEngine::Exceptions::InvalidArgumentValueException, "Value '#{value}' cannot be empty"  \
      if @value.empty?
  end
end
