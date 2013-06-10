require 'singleton'

require_relative 'keyboard_char'
require_relative 'keyboard_key'


module MonkeyEngine

  class MonkeyKeyboardEnUs
    include Singleton

    keys = [
        [ KeyboardKey::make_key('`', 0, '!', 0) ],
    ]

    def initialize
    end

  end

end