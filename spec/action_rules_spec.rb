# frozen_string_literal: true

require 'Monkey'
require 'MonkeyFactory'
require 'MonkeyEngine'
require 'MonkeyManager'
require 'MonkeyActions'
require_relative '../lib/MonkeyKeyboard/keyboard_input'

describe 'ActionRules' do
  context 'get_next_action' do
    it 'throws an exception if the action is not completed' do
      monkey = MonkeyFactory.create :groucho

      monkey.extend(SpecHelpers::SetMonkeyAction)

      keyboard_input = KeyboardInput.new
      keyboard_input.input = %w[H e l l o]

      action = MonkeyActionType.new(monkey, keyboard_input)
      action.action_completed = false

      monkey.force_action(action)

      lambda {
        ActionRules.instance.get_next_action monkey
      }.should raise_error MonkeyEngine::Exceptions::InvalidOperationException
    end

    it 'gets correct action if current action is nil?' do
      monkey = MonkeyFactory.create :groucho

      monkey.extend(SpecHelpers::SetMonkeyAction)

      monkey.force_action(nil)

      ActionRules.instance.get_next_action(monkey).is_a?(MonkeyActionWake).should be true
    end

    it 'gets correct action if current action is MonkeyActionSleep' do
      monkey = MonkeyFactory.create :groucho

      monkey.extend(SpecHelpers::SetMonkeyAction)

      action = MonkeyActionSleep.new(monkey, 6 * 60)
      action.action_completed = true

      monkey.force_action(action)

      ActionRules.instance.get_next_action(monkey).is_a?(MonkeyActionWake).should be true
    end
  end
end
