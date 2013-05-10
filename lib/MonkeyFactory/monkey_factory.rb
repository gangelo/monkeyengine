require 'Monkey/monkey'

module MonkeyFactory
  class << self
    public
    def create(monkey_symbol)
      Monkey.send(:new, monkey_symbol)
    end
  end
end