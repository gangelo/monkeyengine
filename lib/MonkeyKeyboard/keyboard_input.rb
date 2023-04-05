# frozen_string_literal: true

# Represents keyboard input.
class KeyboardInput
  attr_accessor :is_word, :input

  def initialize
    @is_word = false
    @input = []
  end

  def input_to_s
    @input.join.to_s
  end
end
