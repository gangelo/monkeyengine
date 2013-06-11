require 'singleton'

require_relative 'keyboard_char'
require_relative 'keyboard_key'


module MonkeyEngine

  class MonkeyKeyboardEnUs
    include Singleton

    attr_reader :keys, :left_keys, :right_keys

    def initialize

      @keys = [
          # Row 1 of 5
          KeyboardKey::make_key('`', 1, '~', 1, :left),
          KeyboardKey::make_key('1', 1, '!', 1, :left),
          KeyboardKey::make_key('2', 1, '@', 1, :left),
          KeyboardKey::make_key('3', 1, '#', 1, :left),
          KeyboardKey::make_key('4', 1, '$', 1, :left),
          KeyboardKey::make_key('5', 1, '%', 1, :left),
          KeyboardKey::make_key('6', 1, '^', 1, :left),
          KeyboardKey::make_key('7', 1, '&', 1, :right),
          KeyboardKey::make_key('8', 1, '*', 1, :right),
          KeyboardKey::make_key('9', 1, '(', 1, :right),
          KeyboardKey::make_key('0', 1, ')', 1, :right),
          KeyboardKey::make_key('-', 1, '_', 1, :right),
          KeyboardKey::make_key('=', 1, '+', 1, :right),
          KeyboardKey::make_key(:del, 1, :del, 1, :right),

          # Row 2 of 5
          KeyboardKey::make_key(:tab, 2, :tab, 2, :left),
          KeyboardKey::make_key('q', 1, 'Q', 1, :left),
          KeyboardKey::make_key('w', 1, 'W', 1, :left),
          KeyboardKey::make_key('e', 1, 'E', 1, :left),
          KeyboardKey::make_key('r', 1, 'R', 1, :left),
          KeyboardKey::make_key('t', 1, 'T', 1, :left),
          KeyboardKey::make_key('y', 1, 'Y', 1, :left),
          KeyboardKey::make_key('u', 1, 'U', 1, :right),
          KeyboardKey::make_key('i', 1, 'I', 1, :right),
          KeyboardKey::make_key('o', 1, 'O', 1, :right),
          KeyboardKey::make_key('p', 1, 'P', 1, :right),
          KeyboardKey::make_key('', 1, '{', 1, :right),
          KeyboardKey::make_key('', 1, '}', 1, :right),
          KeyboardKey::make_key('\\', 1, '|', 1, :right),

          # Row 3 of 5
          KeyboardKey::make_key(:caps, 3, :caps, 3, :left),
          KeyboardKey::make_key('a', 1, 'A', 1, :left),
          KeyboardKey::make_key('s', 1, 'S', 1, :left),
          KeyboardKey::make_key('d', 1, 'D', 1, :left),
          KeyboardKey::make_key('f', 1, 'F', 1, :left),
          KeyboardKey::make_key('g', 1, 'G', 1, :left),
          KeyboardKey::make_key('h', 1, 'H', 1, :right),
          KeyboardKey::make_key('j', 1, 'J', 1, :right),
          KeyboardKey::make_key('k', 1, 'K', 1, :right),
          KeyboardKey::make_key('l', 1, 'L', 1, :right),
          KeyboardKey::make_key(';', 1, ':', 1, :right),
          KeyboardKey::make_key('\'', 1, '"', 1, :right),
          KeyboardKey::make_key(:enter, 3, :enter, 3, :right),

          # Row 4 of 5
          KeyboardKey::make_key(:shift, 5, :shift, 5, :left),
          KeyboardKey::make_key('z', 1, 'Z', 1, :left),
          KeyboardKey::make_key('x', 1, 'X', 1, :left),
          KeyboardKey::make_key('c', 1, 'C', 1, :left),
          KeyboardKey::make_key('v', 1, 'V', 1, :left),
          KeyboardKey::make_key('b', 1, 'B', 1, :left),
          KeyboardKey::make_key('n', 1, 'N', 1, :right),
          KeyboardKey::make_key('m', 1, 'M', 1, :right),
          KeyboardKey::make_key(',', 1, '<', 1, :right),
          KeyboardKey::make_key('.', 1, '>', 1, :right),
          KeyboardKey::make_key('/', 1, '?', 1, :right),
          KeyboardKey::make_key(:shift, 5, :shift, 5, :right),

          # Row 5 of 5
          KeyboardKey::make_key(:space, 5, :space, 5, :left),
          KeyboardKey::make_key(:space, 5, :space, 5, :right)
      ]

      @left_keys = []
      @right_keys = []

      @keys.each { |key|
        key.keyboard_char.weight.times do
          left_keys.push(key)
        end if key.keyboard_key_section == :left

        key.keyboard_char.weight.times do
          right_keys.push(key)
        end if key.keyboard_key_section == :right
      }
    end

  end

end