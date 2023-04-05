# frozen_string_literal: true

require 'time'

# Defines a base action.
class Action
  attr_reader :value, :weight
  attr_accessor :action_time

  def initialize(value, weight)
    @value = value
    @weight = weight
    @action_time = Time.now
    @action_completed = false

    self
  end

  def action_completed?
    @action_completed
  end

  attr_writer :action_completed

  protected

  def validate
    # throw if invalid state
  end
end
