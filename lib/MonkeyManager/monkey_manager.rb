require 'singleton'

module MonkeyEngine

# Manages monkeys.
  class MonkeyManager
    include Singleton

    def initialize
      @monkeys = Array.new
    end

    public
    def add(monkey)
      # Only add the monkey if it does not already exist by name.
      @monkeys.push(monkey) unless exists_by_name? monkey.monkey_name
    end

    def exists?(monkey)
      @monkeys.include? monkey
    end

    def exists_by_name?(monkey_name)
      true unless get(monkey_name).nil?
    end

    def get(monkey_name)
      @monkeys.first { |monkey| monkey.monkey_name == monkey_name } unless @monkeys.empty?
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
      @monkeys.delete(monkey)
      monkey.kill
    end

    def kill_all!
      @monkeys.each { |monkey| monkey.kill } unless @monkeys.empty?
      @monkeys.clear
    end
  end
end