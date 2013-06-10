require 'singleton'

require_relative 'keyboard_char'
require_relative 'keyboard_key'


module MonkeyEngine

  class MonkeyKeyboardEnUs
    include Singleton

    keys = [
        # Row 1 of 5
        [ KeyboardKey::make_key('`', 0, '~', 0, :left) ],
        [ KeyboardKey::make_key('1', 0, '!', 0, :left) ],
        [ KeyboardKey::make_key('2', 0, '@', 0, :left) ],
        [ KeyboardKey::make_key('3', 0, '#', 0, :left) ],
        [ KeyboardKey::make_key('4', 0, '$', 0, :left) ],
        [ KeyboardKey::make_key('5', 0, '%', 0, :left) ],
        [ KeyboardKey::make_key('6', 0, '^', 0, :left) ],
        [ KeyboardKey::make_key('7', 0, '&', 0, :right) ],
        [ KeyboardKey::make_key('8', 0, '*', 0, :right) ],
        [ KeyboardKey::make_key('9', 0, '(', 0, :right) ],
        [ KeyboardKey::make_key('0', 0, ')', 0, :right) ],
        [ KeyboardKey::make_key('-', 0, '_', 0, :right) ],
        [ KeyboardKey::make_key('=', 0, '+', 0, :right) ],
        [ KeyboardKey::make_key(:del, 0, :del, 0, :right) ],

        # Row 2 of 5
        [ KeyboardKey::make_key(:tab, 2, :tab, 2, :left) ],
        [ KeyboardKey::make_key('q', 0, 'Q', 0, :left) ],
        [ KeyboardKey::make_key('w', 0, 'W', 0, :left) ],
        [ KeyboardKey::make_key('e', 0, 'E', 0, :left) ],
        [ KeyboardKey::make_key('r', 0, 'R', 0, :left) ],
        [ KeyboardKey::make_key('t', 0, 'T', 0, :left) ],
        [ KeyboardKey::make_key('y', 0, 'Y', 0, :left) ],
        [ KeyboardKey::make_key('u', 0, 'U', 0, :right) ],
        [ KeyboardKey::make_key('i', 0, 'I', 0, :right) ],
        [ KeyboardKey::make_key('o', 0, 'O', 0, :right) ],
        [ KeyboardKey::make_key('p', 0, 'P', 0, :right) ],
        [ KeyboardKey::make_key('[', 0, '{', 0, :right) ],
        [ KeyboardKey::make_key(']', 0, '}', 0, :right) ],
        [ KeyboardKey::make_key('\\', 0, '|', 0, :right) ],

        # Row 3 of 5
        [ KeyboardKey::make_key(:caps, 3, :caps, 3, :left) ],
        [ KeyboardKey::make_key('a', 0, 'A', 0, :left) ],
        [ KeyboardKey::make_key('s', 0, 'S', 0, :left) ],
        [ KeyboardKey::make_key('d', 0, 'D', 0, :left) ],
        [ KeyboardKey::make_key('f', 0, 'F', 0, :left) ],
        [ KeyboardKey::make_key('g', 0, 'G', 0, :left) ],
        [ KeyboardKey::make_key('h', 0, 'H', 0, :right) ],
        [ KeyboardKey::make_key('j', 0, 'J', 0, :right) ],
        [ KeyboardKey::make_key('k', 0, 'K', 0, :right) ],
        [ KeyboardKey::make_key('l', 0, 'L', 0, :right) ],
        [ KeyboardKey::make_key(';', 0, ':', 0, :right) ],
        [ KeyboardKey::make_key('\'', 0, '"', 0, :right) ],
        [ KeyboardKey::make_key(:enter, 3, :enter, 3, :right) ],

        # Row 4 of 5
        [ KeyboardKey::make_key(:shift, 5, :shift, 5, :left) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],

        # Row 5 of 5
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
    ]

    def initialize
    end

  end

end