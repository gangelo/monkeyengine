require 'rspec'
require_relative 'spec_helpers'

require 'MonkeyEngine'
require 'MonkeyFactory/monkey_factory'
require 'MonkeyAction/monkey_action_eat'
require 'MonkeyAction/monkey_action_pause'
require 'MonkeyAction/monkey_action_sleep'
require 'MonkeyAction/monkey_action_type'
require 'MonkeyAction/monkey_action_wake'

describe 'Engine' do

  before(:each) do
    @engine = MonkeyEngine::Engine.instance
    @monkey = MonkeyFactory::create :groucho
    @monkey.extend(SpecHelpers::SetMonkeyAction)
  end

  context 'action_eval!' do
    it 'should return action completed if the action is completed' do

      action = MonkeyActionPause.new(@monkey, 10)
      action.action_completed = false
      action.action_time_of_completion = action.action_time

      @monkey.set_action(action)

      @engine.action_eval!(action).should == true
    end

    it 'should return action not completed if the action is not completed' do

      action = MonkeyActionPause.new(@monkey, 60)
      action.action_completed = false

      @monkey.set_action(action)

      @engine.action_eval!(action).should == false
    end
  end

  context 'action_new' do
    it 'should return a new action if a the current action is completed' do

      action = MonkeyActionSleep.new(@monkey, 60*8)
      action.action_completed = true

      @monkey.set_action(action)

      @engine.new_action(@monkey).is_a?(MonkeyActionSleep).should_not==true
    end
  end

  context 'do_action' do
    it 'should do something' do
      pending 'todo'
    end
  end
end