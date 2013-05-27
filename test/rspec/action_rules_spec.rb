require 'rspec'

require 'Monkey/monkey'
require 'MonkeyEngine/action_rules'
require 'MonkeyFactory/monkey_factory'
require 'MonkeyEngine/engine'
require 'MonkeyManager/monkey_manager'
require 'MonkeyAction/monkey_action_eat'
require 'MonkeyAction/monkey_action_pause'
require 'MonkeyAction/monkey_action_sleep'
require 'MonkeyAction/monkey_action_type'
require 'MonkeyAction/monkey_action_wake'
require 'MonkeyAction/monkey_action_dead'

describe 'ActionRules' do

  module SetMonkeyAction
    def set_action(action)
      @action = action
    end
  end

  before(:each) do
    @monkey = MonkeyFactory::create :groucho
    MonkeyEngine::MonkeyManager.instance.add @monkey
  end

  after(:all) do
    # Kill all the threads.
    MonkeyEngine::MonkeyManager.instance.kill_all!

    # Give them a little bit to finish.
    MonkeyEngine::MonkeyManager.instance.join_all(10)
  end

  it 'should throw an exception if the action is completed' do
    @monkey.extend(SetMonkeyAction)

    action = MonkeyActionType.new(@monkey, "Hello World")
    action.action_completed = true

    @monkey.set_action(action)

    lambda {
      ActionRules.new(@monkey)
    }.should raise_error MonkeyEngine::Exceptions::InvalidOperationException
  end
end