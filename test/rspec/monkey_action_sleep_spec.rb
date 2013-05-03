require 'rspec'
require 'monkey'
require 'monkey_action_sleep'
require 'MonkeyEngine/engine'
require_relative 'shared_spec'

describe 'MonkeyActionSleep' do
  before(:each) do

    @monkey = Monkey.new :chico, MonkeyEngine::Engine.instance
    @it = MonkeyActionSleep.new @monkey, 60 * 8 # minutes

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

  it "@value should be is_a? Integer" do
    @it.value.is_a?(Integer).should == true
  end

  it "@value should equal 60 * 8" do
    (@it.value == 60 * 8).should == true
  end

  # Weight
  it '@weight should return the right weight' do
    @it.weight.should == MonkeyActionSleep::WEIGHT
  end

  # validate
  it "should not raise an error if value is within acceptable range" do
    lambda { MonkeyActionSleep.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), 60 * 8) }.should_not raise_error
  end

  it "should raise an error if value is the wrong type" do
    lambda { MonkeyActionSleep.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), :wrong_type) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentTypeException
  end

  it "should raise an error if value is less than min acceptable range" do
    lambda { MonkeyActionSleep.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), 60 * 5) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is greater than max acceptable range" do
    lambda { MonkeyActionSleep.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), 60 * 9) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is nil" do
    lambda { MonkeyActionSleep.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), nil) }.should \
      raise_error MonkeyEngine::Exceptions::NilArgumentException
  end

end