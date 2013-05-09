require 'thread'

# Monkey class.
class Monkey

  attr_reader :monkey_symbol

  public
  def initialize(monkey_symbol)
    @monkey_symbol = monkey_symbol
    initialize_thread
  end

  def kill
    #puts "\n\n#{monkey_symbol} call to kill: #{Time.now}"
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
      #puts "#{monkey_symbol} monkey running...#{Time.now}\n"
      sleep(@sleep_time)
    end
    #puts "\n\n#{monkey_symbol} monkey killed: #{Time.now}"
  end
end