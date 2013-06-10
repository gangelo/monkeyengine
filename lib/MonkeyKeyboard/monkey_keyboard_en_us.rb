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
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
        [ KeyboardKey::make_key('xxxx', 0, 'xxxx', 0, :xxxx) ],
    ]

    def initialize
    end

  end

end