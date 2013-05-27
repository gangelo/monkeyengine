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
  end

  after(:all) do
  end

  context 'get_next_action' do

    it 'should throw an exception if the action is not completed' do
      monkey = MonkeyFactory::create :groucho

      monkey.extend(SetMonkeyAction)

      action = MonkeyActionType.new(monkey, "Hello World")
      action.action_completed = false

      monkey.set_action(action)

      lambda { ActionRules.instance.get_next_action monkey }.should raise_error MonkeyEngine::Exceptions::InvalidOperationException
    end

    it 'should get correct action if current action is nil?' do
      monkey = MonkeyFactory::create :groucho

      monkey.extend(SetMonkeyAction)

      monkey.set_action(nil)

      ActionRules.instance.get_next_action(monkey).is_a?(MonkeyActionWake).should == true
    end

    it 'should get correct action if current action is MonkeyActionSleep' do
      monkey = MonkeyFactory::create :groucho

      monkey.extend(SetMonkeyAction)

      action = MonkeyActionSleep.new(monkey, 6 * 60)
      action.action_completed = true

      monkey.set_action(action)

      ActionRules.instance.get_next_action(monkey).is_a?(MonkeyActionWake).should == true
    end
  end
end