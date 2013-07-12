require 'singleton'
require 'forwardable'

module MonkeyEngine

  # The MonkeyManager.
  #
  # This class provides the functionality needed to manage Monkeys (See Monkey, MonkeyService)
  #
  class MonkeyManager
    include Enumerable
    extend Forwardable

    def_delegators :@monkeys, :each

    include Singleton

    # The constructor
    #
    def initialize
      @monkeys = Array.new
    end

    public

    # Adds the Monkey to the list of Monkeys to be managed.
    #
    # @param (Monkey, #read) monkey The Monkey to add.
    #
    # @return [Monkey] the Monkey added.
    #
    # @raise [MonkeyEngine::Exceptions::InvalidArgumentTypeException] if parameter monkey is not a Monkey object.
    # @raise [MonkeyEngine::Exceptions::UniqueObjectException] if monkey already exists.
    #
    def add(monkey)
      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "Parameter 'monkey' is not Monkey object" unless monkey.is_a? Monkey
      raise MonkeyEngine::Exceptions::UniqueObjectException.new "Monkeys must be unique" if exists? monkey

      @monkeys.push(monkey)
      monkey
    end

    # Returns the total count of Monkey objects being managed by this MonkeyManager.
    #
    # @return [int] The Monkey count.
    #
    def count
      @monkeys.count
    end

    # Returns a [Boolean] indicating whether or not the Monkey exists (e.g. is currently being managed by this MonkeyManager).
    #
    # @param [Monkey, #read] monkey The Monkey to check.
    #
    # @return [Boolean] true if the Monkey is currently being manager by this MonkeyManager, false otherwise.
    #
    def exists?(monkey)
      true unless get(monkey).nil?
    end

    # Returns a [Boolean] indicating whether or not the Monkey is alive (Monkey#alive?).
    #
    # @param [Monkey] monkey The Monkey to check.
    #
    # @return [Boolean] true if the Monkey is currently active (Monkey#.alive?), false otherwise.
    #
    def alive?(monkey)
      monkey = get(monkey)
      monkey.alive? unless monkey.nil?
    end

    # Returns the Monkey indicated by *monkey*.
    #
    # @param [Monkey, Symbol, String, #read] monkey The Monkey to return.
    #
    # @note Monkey#monkey_symbol is interrogated. If *monkey* is a [Monkey] object, Monkey#monkey_symbol is used;
    #    if *monkey* is a [Symbol], it is used; if *monkey* is a [String], String#to_sym is used.
    #
    # @return [Monkey] The Monkey if it exists.
    #
    # @raise [MonkeyEngine::Exceptions::InvalidArgumentTypeException] if parameter monkey is not a Monkey, Symbol, or String object.
    #
    def get(monkey)
      return nil if @monkeys.empty?

      # TODO: This seems inefficient.
      return @monkeys.select { |m| m.monkey_symbol == monkey }.first if monkey.is_a? Symbol
      return @monkeys.select { |m| m.monkey_symbol == monkey.to_sym }.first if monkey.is_a? String
      return @monkeys.select { |m| m.monkey_symbol == monkey.monkey_symbol }.first if monkey.is_a? Monkey

      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "Parameter 'monkey' is not a Symbol, String or Monkey object"
    end

    # Returns an Array of Monkey objects managed by this MonkeyManager.
    #
    # @return [Array] An Array of Monkey objects managed by this MonkeyManager.
    #
    def get_all
      return @monkeys if @monkeys.empty?
      @monkeys.dup
    end

    # Removes the Monkey from the list of Monkeys being managed by this MonkeyManager.
    #
    # @param [Monkey] monkey The Monkey to delete.
    #
    # @note The Monkey to be deleted becomes unmanaged; the Monkey is NOT killed (Monkey#kill)
    #
    # @return [Monkey, nil] Returns the deleted Monkey, or nil if no matching Monkey was found to delete.
    #
    def delete(monkey)
      @monkeys.delete(monkey)
    end

    # Suspends the calling threads execution until all Monkey threads exit, or,
    # until _limit_ seconds have passed.
    #
    # @param [int] limit The seconds to wait for all Monkey threads to exit, or _nil_ to
    #   wait indefinitely.
    #
    # @return [Array, nil] Returns an [Array] of Monkey objects, or, nil, if no Monkey objects are being managed by
    #    this MonkeyManager.
    #
    def join_all(limit=nil)
      limit = 0 unless limit.nil?
      @monkeys.each { |monkey| monkey.join limit } unless @monkeys.empty?
    end

    # Kills the monkey.
    #
    # @param [Monkey, #read/#write, Symbol, String] monkey the Monkey to kill.
    #
    # @note The Monkey#monkey_do method executed continually by Monkey#thread is
    #  terminated.
    #
    # @return [Monkey] the Monkey that was killed.
    #
    def kill!(monkey)
      monkey = get(monkey)
      return if monkey.nil?

      @monkeys.delete(monkey)
      monkey.kill

      monkey
    end

    # Kills all monkeys managed by this MonkeyManager.
    #
    # @note The Monkey#monkey_do method executed continually by Monkey#thread, for each Monkey is
    #  terminated.
    #
    # @return [Array] an Array of Monkey objects that were killed.
    #
    def kill_all!
      @monkeys.each { |monkey| monkey.kill } unless @monkeys.empty?
      monkeys = @monkeys.dup
      @monkeys.clear

      monkeys
    end
  end
end