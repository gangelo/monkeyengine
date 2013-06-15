require 'rspec'
require 'Monkey/monkey'
require 'MonkeyAction/monkey_action_type'
require 'MonkeyFactory/monkey_factory'
require 'MonkeyEngine/engine'
require_relative 'shared_spec'

describe 'MonkeyActionType' do
  before(:all) do

    @monkey = MonkeyFactory::create :typing_monkey1
    @it = MonkeyActionType.new @monkey, %w{a b c d e f .}

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
    @it.is_a?(MonkeyActionType).should == true
  end

  # Monkey
  it '@monkey be the same monkey' do
    @it.monkey.should == @monkey
  end

  # Value
  it '@value should return the right value' do
    @it.value.should == %w{a b c d e f .}
  end

  it "@value should be is_a? Array" do
    @it.value.is_a?(Array).should == true
  end

  it "@value should not be nil?" do
    @it.value.nil?.should_not == true
  end

  # Weight
  it '@weight should return the right weight' do
    @it.weight.should == MonkeyActionType::WEIGHT
  end

  # validate
  it "should not raise an error if value is valid" do
    monkey = MonkeyFactory::create(:typing_monkey2)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionType.new(monkey, %w{w o r d .}) }.should_not raise_error
  end

  it "should raise an error if value is the wrong type" do
    monkey = MonkeyFactory::create(:typing_monkey3)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionType.new(monkey, :wrong_type) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentTypeException
  end

  it "should raise an error if value is empty?" do
    monkey = MonkeyFactory::create(:typing_monkey4)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionType.new(monkey, %w{}) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is nil" do
    monkey = MonkeyFactory::create(:typing_monkey5)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionType.new(monkey, nil) }.should \
      raise_error MonkeyEngine::Exceptions::NilArgumentException
  end
end