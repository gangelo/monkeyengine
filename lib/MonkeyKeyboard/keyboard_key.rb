require_relative 'keyboard_char'

# Represents a keyboard key.
class KeyboardKey
  attr_reader :keyboard_char, :keyboard_shift_char, :keyboard_key_section

  def initialize(keyboard_char, keyboard_shift_char, keyboard_key_section)
    # TODO: Check keyboard_char is_a? KeyboardChar
    # TODO: Check keyboard_shift_char is_a? KeyboardChar
    # TODO: Check keyboard_key_section is :left or :right

    @keyboard_char = keyboard_char
    @keyboard_shift_char = keyboard_shift_char
    @keyboard_key_section = keyboard_key_section
  end

  def self.make_key(char, char_weight, shift_char, shift_char_weight, keyboard_key_section)
    # TODO: Check keyboard_key_section is :left or :right

    keyboard_char = KeyboardChar.new char, char_weight
    keyboard_shift_char = KeyboardChar.new shift_char, shift_char_weight

    KeyboardKey.new keyboard_char, keyboard_shift_char, keyboard_key_section
  end
end