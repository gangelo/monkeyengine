# Represents keyboard input.
class KeyboardInput

  attr_accessor :is_word, :input

  def initialize
    @is_word = false
    @input = Array.new
  end
end