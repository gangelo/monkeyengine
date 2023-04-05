# frozen_string_literal: true

require 'Monkey'
require 'MonkeyActions'
require 'MonkeyFactory'
require 'MonkeyEngine'

require_relative 'support/shared_examples'

describe 'MonkeyActionSleep' do
  before(:all) do
    @monkey = MonkeyFactory.create :sleeping_monkey1
    @it = MonkeyActionSleep.new @monkey, 60 * 8 # milliseconds

    MonkeyEngine::MonkeyManager.instance.add(@monkey)
  end

  after(:all) do
    # Kill all the threads.
    MonkeyEngine::MonkeyManager.instance.kill_all!

    # Give them a little bit to finish.
    MonkeyEngine::MonkeyManager.instance.join_all(10)
  end

  it_should_behave_like 'MonkeyAction'

  it '@it should be the correct type' do
    @it.is_a?(MonkeyActionSleep).should == true
  end

  # Monkey
  it '@monkey should be the same monkey' do
    @it.monkey.should == @monkey
  end

  # Value
  it '@value should return the right value' do
    @it.value.should == 60 * 8
  end

  it '@value should be is_a? Integer' do
    @it.value.is_a?(Integer).should == true
  end

  it '@value should equal 60 * 8' do
    (@it.value == 60 * 8).should == true
  end

  # Weight
  it '@weight should return the right weight' do
    @it.weight.should == MonkeyActionSleep::WEIGHT
  end

  # validate
  it 'should not raise an error if value is within acceptable range' do
    monkey = MonkeyFactory.create(:sleeping_monkey2)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    -> { MonkeyActionSleep.new(monkey, 60 * 8) }.should_not raise_error
  end

  it 'should raise an error if value is the wrong type' do
    monkey = MonkeyFactory.create(:sleeping_monkey3)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    -> { MonkeyActionSleep.new(monkey, :wrong_type) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentTypeException
  end

  it 'should raise an error if value is less than min acceptable range' do
    monkey = MonkeyFactory.create(:sleeping_monkey4)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    -> { MonkeyActionSleep.new(monkey, 60 * 5) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it 'should raise an error if value is greater than max acceptable range' do
    monkey = MonkeyFactory.create(:sleeping_monkey5)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    -> { MonkeyActionSleep.new(monkey, 60 * 9) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it 'should raise an error if value is nil' do
    monkey = MonkeyFactory.create(:sleeping_monkey6)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    -> { MonkeyActionSleep.new(monkey, nil) }.should \
      raise_error MonkeyEngine::Exceptions::NilArgumentException
  end
end
