require 'time'

# Action.
class Action
  attr_reader :value, :weight
  attr_accessor :action_time, :action_completed

  def initialize(value, weight)
    @value = value
    @weight = weight
    @action_time = Time.now
    @action_completed = false
  end

  protected
  def validate
    # throw if invalid state
  end
end