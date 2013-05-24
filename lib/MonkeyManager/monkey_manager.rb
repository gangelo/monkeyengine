require 'singleton'
require 'forwardable'

module MonkeyEngine

  # Manages monkeys.
  class MonkeyManager
    include Enumerable
    extend Forwardable

    def_delegators :@monkeys, :each

    include Singleton

    def initialize
      @monkeys = Array.new
    end

    public
    def add(monkey)
      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "Parameter 'monkey' is not Monkey object" unless monkey.is_a? Monkey
      raise MonkeyEngine::Exceptions::UniqueObjectException.new "Monkeys must be unique" if exists? monkey

      @monkeys.push(monkey)
      monkey
    end

    def count
      @monkeys.count
    end

    def exists?(monkey)
      true unless get(monkey).nil?
    end

    def alive?(monkey)
      monkey = get(monkey)
      monkey.alive? unless monkey.nil?
    end

    def get(monkey)
      return nil if @monkeys.empty?

      # TODO: This seems inefficient.
      return @monkeys.select { |m| m.monkey_symbol == monkey }.first if monkey.is_a? Symbol
      return @monkeys.select { |m| m.monkey_symbol == monkey.to_sym }.first if monkey.is_a? String
      return @monkeys.select { |m| m.monkey_symbol == monkey.monkey_symbol }.first if monkey.is_a? Monkey

      raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "Parameter 'monkey' is not a Symbol, String or Monkey object"
    end

    # Deletes but does not kill.
    def delete(monkey)
      @monkeys.delete(monkey)
    end

    def join_all(limit=nil)
      limit = 0 unless limit.nil?
      @monkeys.each { |monkey| monkey.join limit } unless @monkeys.empty?
    end

    def kill!(monkey)
      monkey = get(monkey)
      return if monkey.nil?

      @monkeys.delete(monkey)
      monkey.kill
    end

    def kill_all!
      @monkeys.each { |monkey| monkey.kill } unless @monkeys.empty?
      @monkeys.clear
    end
  end
end