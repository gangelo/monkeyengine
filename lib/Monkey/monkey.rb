require 'thread'
require 'Helpers/protected_constructor'

# Monkey class.
class Monkey
  include ProtectedConstructor

  attr_reader :monkey_symbol

  protected
  def initialize(monkey_symbol)
    @monkey_symbol = monkey_symbol
    initialize_thread
  end

  public

  def kill
    @kill_thread = true
  end

  def thread
    @thread
  end

  def alive?
    @thread.alive?
  end

  protected
  def initialize_thread
    @sleep_time = 1.0/250.0
    @kill_thread = false

    @thread = Thread.new {
      monkey_do
    }

    #@thread.freeze
    @thread.abort_on_exception = true
  end

  def monkey_do
    until @kill_thread do
      sleep(@sleep_time)
    end
  end
end