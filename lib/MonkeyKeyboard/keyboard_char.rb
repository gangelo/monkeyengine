# Represents a keyboard character.
class KeyboardChar

  attr_reader :char, :weight

  def initialize(char)
    @char = char
    self
  end
end