# frozen_string_literal: true

require 'MonkeyKeyboardEnUs'

describe 'KeyboardChar' do
  it 'returns the proper char that it represents' do
    keyboard_char = KeyboardChar.new 'a'

    keyboard_char.char.should == 'a'
  end
end
