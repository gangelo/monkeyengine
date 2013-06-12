require 'rspec'
require 'MonkeyKeyboard/keyboard_key'

describe 'KeyboardKey' do

  it 'should should return correct properties' do

    keyboard_key = KeyboardKey.new 'a', 'A', :left, 1

    keyboard_key.keyboard_char.should == 'a'
    keyboard_key.keyboard_shift_char.should == 'A'
    keyboard_key.keyboard_key_section.should == :left
    keyboard_key.keyboard_key_weight.should == 1

  end
end