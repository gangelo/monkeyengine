class KeyboardKeyEvaluator
  def initialize
    @shift_on = false
    @caps_on = false
  end

  def get_char(keyboard_key)
    @shift_on = !@shift_on if keyboard_key.keyboard_char.char == :shift
    @caps_on = !@shift_on if keyboard_key.keyboard_char.char == :caps

    return nil if keyboard_key.keyboard_char.char.is_a? Symbol

    if @shift_on
      return keyboard_key.keyboard_shift_char.char
    end

    char = keyboard_key.keyboard_char.char

    if @caps_on
      return char.upcase
    end

    char
  end
end