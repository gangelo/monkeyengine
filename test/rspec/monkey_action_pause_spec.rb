require 'rspec'
require 'monkey'
require 'monkey_action_pause'
require 'MonkeyEngine/engine'
require_relative 'shared_spec'

describe 'MonkeyActionPause' do
  before(:each) do

    @monkey = Monkey.new :groucho, MonkeyEngine::Engine.instance
    @it = MonkeyActionPause.new @monkey, 250 # milliseconds

  end

  it_should_behave_like 'MonkeyAction'

  it '@it should be the correct type' do
    @it.is_a?(MonkeyActionPause).should == true
  end

  # Monkey
  it '@monkey be the same monkey' do
    @it.monkey.should == @monkey
  end

  # Value
  it '@value should return the right value' do
    @it.value.should == 250
  end

  it "@value should be is_a? Integer" do
    @it.value.is_a?(Integer).should == true
  end

  it "@value should >= 1" do
    (@it.value >= 1).should == true
  end

  # Weight
  it '@weight should return the right weight' do
    @it.weight.should == MonkeyActionPause::WEIGHT
  end

  # validate
  it "should not raise an error if value is within acceptable range" do
    lambda { MonkeyActionPause.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), 5000) }.should_not raise_error
  end

  it "should raise an error if value is the wrong type" do
    lambda { MonkeyActionPause.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), :wrong_type) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentTypeException
  end

  it "should raise an error if value is less than min acceptable range" do
    lambda { MonkeyActionPause.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), -5000) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is greater than max acceptable range" do
    lambda { MonkeyActionPause.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), 11000) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is nil" do
    lambda { MonkeyActionPause.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), nil) }.should \
      raise_error MonkeyEngine::Exceptions::NilArgumentException
  end

end