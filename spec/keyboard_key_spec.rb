# frozen_string_literal: true

require 'MonkeyKeyboardEnUs'

describe 'KeyboardKey' do
  it 'shoulds return correct properties' do
    keyboard_key = KeyboardKey.new 'a', 'A', :left, 1

    keyboard_key.keyboard_char.should eq 'a'
    keyboard_key.keyboard_shift_char.should eq 'A'
    keyboard_key.keyboard_key_section.should eq :left
    keyboard_key.keyboard_key_weight.should eq 1
  end
end
