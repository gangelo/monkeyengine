# frozen_string_literal: true

class KeyboardKeyEvaluator
  def initialize
    @shift_on = false
    @caps_on = false
  end

  def get_char(keyboard_key)
    @shift_on = !@shift_on if keyboard_key.keyboard_char.char == :shift
    @caps_on = !@shift_on if keyboard_key.keyboard_char.char == :caps

    return if keyboard_key.keyboard_char.char.is_a? Symbol

    return keyboard_key.keyboard_shift_char.char if @shift_on

    char = keyboard_key.keyboard_char.char

    return char.upcase if @caps_on

    char
  end
end
