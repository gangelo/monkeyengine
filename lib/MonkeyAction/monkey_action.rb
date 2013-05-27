require 'Action/action'

# MonkeyAction.
class MonkeyAction < Action
  attr_reader :monkey

  def initialize(monkey, value, weight)
    super value, weight

    @monkey = monkey

    self
  end
end