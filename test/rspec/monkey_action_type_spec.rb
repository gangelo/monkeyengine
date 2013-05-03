require 'rspec'
require 'monkey'
require 'monkey_action_type'
require 'MonkeyEngine/engine'
require_relative 'shared_spec'

describe 'MonkeyActionType' do
  before(:each) do

    @monkey = Monkey.new :harpo, MonkeyEngine::Engine.instance
    @it = MonkeyActionType.new @monkey, 'abcdef.'

  end

  it_should_behave_like 'MonkeyAction'

  it '@it should be the correct type' do
    @it.is_a?(MonkeyActionType).should == true
  end

  # Monkey
  it '@monkey be the same monkey' do
    @it.monkey.should == @monkey
  end

  # Value
  it '@value should return the right value' do
    @it.value.should == 'abcdef.'
  end

  it "@value should be is_a? String" do
    @it.value.is_a?(String).should == true
  end

  it "@value should not be empty?" do
    @it.value.empty?.should_not == true
  end

  # Weight
  it '@weight should return the right weight' do
    @it.weight.should == MonkeyActionType::WEIGHT
  end

  # validate
  it "should not raise an error if value is valid" do
    lambda { MonkeyActionType.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), 'a word.') }.should_not raise_error
  end

  it "should raise an error if value is the wrong type" do
    lambda { MonkeyActionType.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), :wrong_type) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentTypeException
  end

  it "should raise an error if value is empty" do
    lambda { MonkeyActionType.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), '') }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is nil" do
    lambda { MonkeyActionType.new(Monkey.new(:chico, MonkeyEngine::Engine.instance), nil) }.should \
      raise_error MonkeyEngine::Exceptions::NilArgumentException
  end
end