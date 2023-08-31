# frozen_string_literal: true

require 'MonkeyEngine'
require 'MonkeyActions'
require 'MonkeyFactory'

describe 'Engine' do
  before do
    @engine = MonkeyEngine::Engine.instance
    @monkey = MonkeyFactory.create :groucho
    @monkey.extend(SpecHelpers::SetMonkeyAction)
  end

  context 'action_eval!' do
    it 'returns action completed if the action is completed' do
      action = MonkeyActionPause.new(@monkey, 10)
      action.action_completed = false
      action.action_time_of_completion = action.action_time

      @monkey.force_action(action)

      @engine.action_eval!(action).should be true
    end

    it 'returns action not completed if the action is not completed' do
      action = MonkeyActionPause.new(@monkey, 60)
      action.action_completed = false

      @monkey.force_action(action)

      @engine.action_eval!(action).should be false
    end
  end

  context 'action_new' do
    it 'returns a new action if a the current action is completed' do
      action = MonkeyActionSleep.new(@monkey, 60 * 8)
      action.action_completed = true

      @monkey.force_action(action)

      @engine.new_action(@monkey).is_a?(MonkeyActionSleep).should_not == true
    end
  end

  context 'do_action' do
    it 'does something' do
      skip 'todo'
    end
  end
end
