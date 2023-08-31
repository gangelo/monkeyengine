# frozen_string_literal: true

require_relative 'monkey_action'
require 'MonkeyEngine/exceptions'

# Monkey action:  one that is timed based on an Integer.
class MonkeyTimedAction < MonkeyAction
  attr_accessor :action_time_of_completion

  def initialize(monkey, value, weight)
    super monkey, value, weight

    @action_time_of_completion = nil

    validate
  end

  protected

  def validate
    raise MonkeyEngine::Exceptions::NilArgumentException, "Value '#{value}' cannot be nil" \
      if @value.nil?

    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException, "Value '#{value}' is not a valid argument type" \
      unless @value.is_a?(Integer)
  end
end
