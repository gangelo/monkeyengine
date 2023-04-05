# frozen_string_literal: true

require 'MonkeyKeyboardEnUs'

describe 'MonkeyKeyboardEnUs' do
  before(:all) do
    @it = MonkeyEngine::MonkeyKeyboardEnUs.instance
  end

  context 'keys' do
  end

  context 'left_keys' do
    it 'should have the correct amount of keyboard entries on the left side of the keyboard' do
      key_count = 0

      @it.keys.each do |key|
        key_count += key.keyboard_key_weight if key.keyboard_key_section == :left
      end

      @it.left_keys.count.should == key_count
    end
  end

  context 'right_keys' do
    it 'should have the correct amount of keyboard entries on the right side of the keyboard' do
      key_count = 0

      @it.keys.each do |key|
        key_count += key.keyboard_key_weight if key.keyboard_key_section == :right
      end

      @it.right_keys.count.should == key_count
    end
  end
end
