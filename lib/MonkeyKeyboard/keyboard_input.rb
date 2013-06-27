# Represents keyboard input.
class KeyboardInput

  attr_accessor :is_word, :input

  def initialize
    @is_word = false
    @input = Array.new
  end

  def input_to_s
    @input.join.to_s
  end
end