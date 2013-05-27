require 'thread'
require 'MonkeyAction/monkey_action_dead'
require 'MonkeyService/monkey_service'
require 'Helpers/protected_constructor'

# Monkey class.
class Monkey
  include ProtectedConstructor

  attr_reader :monkey_symbol, :action

  protected
  def initialize(monkey_symbol)
    @monkey_symbol = monkey_symbol
    @monkey_service = MonkeyEngine::MonkeyService.instance
    self
  end

  public
  def alive?
    return false if @thread.nil?
    @thread.alive?
  end

  def current_action
    return MonkeyActionDead.new(self) unless alive?
    @action
  end

  def kill
    @kill_thread = true
  end

  def start
    raise MonkeyEngine::Exceptions::InvalidOperationException.new "The monkey [#{@monkey_symbol}] thread is already started" \
      if alive?
    initialize_thread
    self
  end

  def thread
    @thread
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
      @action = @monkey_service.new_action(self) if @action.nil? || @action.action_completed?
      @monkey_service.monkey_do @action unless @monkey_service.action_eval! @action
      sleep(@sleep_time)
    end
  end
end