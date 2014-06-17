require 'Monkey'
require 'MonkeyActions'
require 'MonkeyFactory'
require 'MonkeyEngine'

require_relative 'support/shared_examples'

describe 'MonkeyActionEat' do
  before(:all) do

    @monkey = MonkeyFactory.create :eating_monkey1
    @it = MonkeyActionEat.new @monkey, 30 # minutes

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
    @it.is_a?(MonkeyActionEat).should == true
  end

  # Monkey
  it '@monkey should be the same monkey' do
    @it.monkey.should == @monkey
  end

  # Value
  it '@value should return the right value' do
    @it.value.should == 30
  end

  it "@value should be is_a? Integer" do
    @it.value.is_a?(Integer).should == true
  end

  # Weight
  it '@weight should return the right weight' do
    @it.weight.should == MonkeyActionEat::WEIGHT
  end

  # validate
  it "should not raise an error if value is within acceptable range" do
    monkey = MonkeyFactory.create(:eating_monkey2)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionEat.new(monkey, 40) }.should_not raise_error
  end

  it "should raise an error if value is the wrong type" do
    monkey = MonkeyFactory.create(:eating_monkey3)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionEat.new(monkey, :wrong_type) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentTypeException
  end

  it "should raise an error if value is less than min acceptable range" do
    monkey = MonkeyFactory.create(:eating_monkey4)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionEat.new(monkey, 29) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is greater than max acceptable range" do
    monkey = MonkeyFactory.create(:eating_monkey5)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionEat.new(monkey, 61) }.should \
      raise_error MonkeyEngine::Exceptions::InvalidArgumentValueException
  end

  it "should raise an error if value is nil" do
    monkey = MonkeyFactory.create(:eating_monkey6)
    MonkeyEngine::MonkeyManager.instance.add(monkey)
    lambda { MonkeyActionEat.new(monkey, nil) }.should \
      raise_error MonkeyEngine::Exceptions::NilArgumentException
  end

end