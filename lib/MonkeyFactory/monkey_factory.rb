# frozen_string_literal: true

require 'Monkey'

module MonkeyFactory
  class << self
    def create(monkey_symbol)
      # Call the protected constructor - monkeys can only be created
      # via the MonkeyFactory.
      Monkey.send(:new, monkey_symbol)
    end
  end
end
