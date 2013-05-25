require 'rspec'
require 'Monkey/monkey'
require 'MonkeyAction/monkey_action_pause'
require 'MonkeyFactory/monkey_factory'
require 'MonkeyEngine/engine'
require 'MonkeyManager/monkey_manager'
require_relative 'shared_spec'

describe 'MonkeyActionPause' do
  before(:all) do

    @monkey = MonkeyFactory.create :pausing_monkey1
    @it = MonkeyActionPause.new @monkey, 1 # 1 second

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
    @it.is_a?(MonkeyActionPause).should == true
  end

  # Monkey
  it '@monkey be the same monkey' do
    @it.monkey.should == @monkey
  end

  # Value
  it '@value should return the right value' do
    @it.value.should == 1
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
    monkey = MonkeyFactory.create(:pausing_monkey2)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionPause.new(monkey, 5) }.should_not raise_error
  end

  it "should raise an error if value is the wrong type" do
    monkey = MonkeyFactory.create(:pausing_monkey3)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionPause.new(monkey, :wrong_type) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentTypeException
  end

  it "should raise an error if value is less than min acceptable range" do
    monkey = MonkeyFactory.create(:pausing_monkey4)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionPause.new(monkey, -1) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is greater than max acceptable range" do
    monkey = MonkeyFactory.create(:pausing_monkey5)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionPause.new(monkey, 61) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is nil" do
    monkey = MonkeyFactory.create(:pausing_monkey6)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionPause.new(monkey, nil) }.should \
      raise_error MonkeyEngine::Exceptions::NilArgumentException
  end

end