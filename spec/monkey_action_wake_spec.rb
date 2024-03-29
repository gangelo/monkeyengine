# frozen_string_literal: true

require 'Monkey'
require 'MonkeyActions'
require 'MonkeyFactory'
require 'MonkeyEngine'

require_relative 'support/shared_examples'

describe 'MonkeyActionWake' do
  before(:all) do
    @monkey = MonkeyFactory.create :waking_monkey1
    @it = MonkeyActionWake.new @monkey

    MonkeyEngine::MonkeyManager.instance.add(@monkey)
  end

  after(:all) do
    # Kill all the threads.
    MonkeyEngine::MonkeyManager.instance.kill_all!

    # Give them a little bit to finish.
    MonkeyEngine::MonkeyManager.instance.join_all(10)
  end

  it_behaves_like 'MonkeyAction'

  it '@it should be the correct type' do
    @it.is_a?(MonkeyActionWake).should be true
  end

  # Monkey
  it '@monkey should be the same monkey' do
    @it.monkey.should == @monkey
  end

  # Value
  it '@value should return the right value' do
    @it.value.should be true
  end

  it '@value should be is_a? TrueClass' do
    @it.value.is_a?(TrueClass).should be true
  end

  # Weight
  it '@weight should return the right weight' do
    @it.weight.should == MonkeyActionWake::WEIGHT
  end

  # validate
  it 'does not raise an error if value is within acceptable range' do
    monkey = MonkeyFactory.create(:waking_monkey2)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    -> { MonkeyActionWake.new(monkey) }.should_not raise_error
  end
end
