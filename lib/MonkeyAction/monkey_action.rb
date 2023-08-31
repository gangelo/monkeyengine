# frozen_string_literal: true

require 'Action/action'

# MonkeyAction.
class MonkeyAction < Action
  attr_reader :monkey

  def initialize(monkey, value, weight)
    super value, weight

    @monkey = monkey
  end
end
