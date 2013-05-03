
# Monkey class.
class Monkey

  #private
  attr_reader :monkey_name, :engine

  public
  def initialize(monkey_name, engine)
    @monkey_name = monkey_name
    @engine = engine
  end

  def do_action
    #action = Action.new self, :type, 'word'
    #engine.do_aciton(action)
  end
end