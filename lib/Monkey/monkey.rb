# frozen_string_literal: true

require 'MonkeyActions'
require 'MonkeyService'
require 'ProtectedConstructor'

# Monkey class.
#
# @note The Monkey class represents a virtual monkey that performs particular _actions_
#   that may or may not be typical of a real monkey.  Monkey _actions_ are derived from class _MonkeyAction_.
#
# @note The constructor for this class is protected; to instantiate a managed _Monkey_, use
#   MonkeyEngine::MonkeyService#add; to instantiate an unmanaged _Monkey_, use MonkeyFactory::create.
#
# @see MonkeyAction
# @see MonkeyEngine::MonkeyService#add
# @see MonkeyFactory::create
#
class Monkey
  include ProtectedConstructor

  # @!attribute [r] monkey_symbol
  #   @return [Symbol] the _Symbol_ that identifies this Monkey.
  # @!attribute [r] action
  #   @return [MonkeyAction] the current _MonkeyAction_ that this _Monkey_ is engaged in.
  #
  attr_reader :monkey_symbol, :action

  protected

  def initialize(monkey_symbol)
    @monkey_symbol = monkey_symbol
    @monkey_service = MonkeyEngine::MonkeyService.instance
  end

  public

  # Determines if the Monkey is alive.
  #
  # @note The Monkey is considered alive if the Monkey#thread.alive? is true.
  #
  # @return [Boolean] true if the Monkey is alive, false otherwise.
  #
  def alive?
    return false if @thread.nil?

    @thread.alive?
  end

  # Retrieves the current _Action_ that this Monkey is engaged in.
  #
  # @return [MonkeyAction] The _MonkeyAction_.
  #
  def current_action
    return MonkeyActionDead.new(self) unless alive?

    @action
  end

  # Kills this Monkey.
  #
  # @note The Monkey#monkey_do method executed continually by Monkey#thread is
  #  terminated.
  #
  def kill
    @kill_thread = true
  end

  # Starts this Monkey.
  #
  # @raise [MonkeyEngine::Exceptions::InvalidOperationException] if Monkey#thread is already alive? (started).
  #
  # @return [Monkey, self]
  #
  def start
    if alive?
      raise MonkeyEngine::Exceptions::InvalidOperationException,
        "The monkey [#{@monkey_symbol}] thread is already started"
    end

    initialize_thread
    self
  end

  # The thread that this Monkey uses to perform its actions.
  #
  # @return [Thread]
  #
  attr_reader :thread

  protected

  def initialize_thread
    @sleep_time = 1.0 / 250.0
    @kill_thread = false

    @thread = Thread.new do
      monkey_do
    end

    # @thread.freeze
    @thread.abort_on_exception = true
  end

  def monkey_do
    until @kill_thread
      @action = @monkey_service.new_action(self) if @action.nil? || @action.action_completed?
      @monkey_service.monkey_do @action unless @monkey_service.action_eval! @action
      sleep(@sleep_time)
    end
  end
end
