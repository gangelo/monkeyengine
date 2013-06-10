# Represents a keyboard character.
class KeyboardChar

  attr_reader :char, :weight

  def initialize(char, weight)
    @char = char
    @weight = weight

    self
  end
end