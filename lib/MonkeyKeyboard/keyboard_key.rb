# frozen_string_literal: true

require_relative 'keyboard_char'

# Represents a keyboard key.
class KeyboardKey
  attr_reader :keyboard_char, :keyboard_shift_char, :keyboard_key_section, :keyboard_key_weight

  def initialize(keyboard_char, keyboard_shift_char, keyboard_key_section, keyboard_key_weight)
    # TODO: Check keyboard_char is_a? KeyboardChar
    # TODO: Check keyboard_shift_char is_a? KeyboardChar
    # TODO: Check keyboard_key_section is :left or :right

    @keyboard_char = keyboard_char
    @keyboard_shift_char = keyboard_shift_char
    @keyboard_key_section = keyboard_key_section
    @keyboard_key_weight = keyboard_key_weight
  end

  def self.make_key(char, shift_char, keyboard_key_section, keyboard_key_weight)
    # TODO: Check keyboard_key_section is :left or :right

    keyboard_char = KeyboardChar.new char
    keyboard_shift_char = KeyboardChar.new shift_char

    KeyboardKey.new keyboard_char, keyboard_shift_char, keyboard_key_section, keyboard_key_weight
  end
end
