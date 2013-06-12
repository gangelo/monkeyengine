require 'rspec'
require 'MonkeyKeyboard/keyboard_char'

describe 'KeyboardChar' do

  it 'should return the proper char that it represents' do

    keyboard_char = KeyboardChar.new 'a'

    keyboard_char.char.should == 'a'

  end
end