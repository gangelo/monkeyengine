require 'singleton'
require 'LittleWeasel'

require_relative 'keyboard_char'
require_relative 'keyboard_key'
require_relative 'keyboard_input'
require_relative 'keyboard_key_evaluator'


module MonkeyEngine

  class MonkeyKeyboardEnUs
    include Singleton

    attr_reader :keys, :left_keys, :right_keys

    def initialize

      @keys = [
          # Row 1 of 5
          KeyboardKey::make_key('`', '~', :left, 1),
          KeyboardKey::make_key('1', '!', :left, 1),
          KeyboardKey::make_key('2', '@', :left, 1),
          KeyboardKey::make_key('3', '#', :left, 1),
          KeyboardKey::make_key('4', '$', :left, 1),
          KeyboardKey::make_key('5', '%', :left, 1),
          KeyboardKey::make_key('6', '^', :left, 1),
          KeyboardKey::make_key('7', '&', :right, 1),
          KeyboardKey::make_key('8', '*', :right, 1),
          KeyboardKey::make_key('9', '(', :right, 1),
          KeyboardKey::make_key('0', ')', :right, 1),
          KeyboardKey::make_key('-', '_', :right, 1),
          KeyboardKey::make_key('=', '+', :right, 1),
          KeyboardKey::make_key(:del, :del, :right, 1),

          # Row 2 of 5
          KeyboardKey::make_key(:tab, :tab, :left, 2),
          KeyboardKey::make_key('q', 'Q', :left, 1),
          KeyboardKey::make_key('w', 'W', :left, 1),
          KeyboardKey::make_key('e', 'E', :left, 1),
          KeyboardKey::make_key('r', 'R', :left, 1),
          KeyboardKey::make_key('t', 'T', :left, 1),
          KeyboardKey::make_key('y', 'Y', :left, 1),
          KeyboardKey::make_key('u', 'U', :right, 1),
          KeyboardKey::make_key('i', 'I', :right, 1),
          KeyboardKey::make_key('o', 'O', :right, 1),
          KeyboardKey::make_key('p', 'P', :right, 1),
          KeyboardKey::make_key('', '{', :right, 1),
          KeyboardKey::make_key('', '}', :right, 1),
          KeyboardKey::make_key('\\', '|', :right, 1),

          # Row 3 of 5
          KeyboardKey::make_key(:caps, :caps, :left, 3),
          KeyboardKey::make_key('a', 'A', :left, 1),
          KeyboardKey::make_key('s', 'S', :left, 1),
          KeyboardKey::make_key('d', 'D', :left, 1),
          KeyboardKey::make_key('f', 'F', :left, 1),
          KeyboardKey::make_key('g', 'G', :left, 1),
          KeyboardKey::make_key('h', 'H', :right, 1),
          KeyboardKey::make_key('j', 'J', :right, 1),
          KeyboardKey::make_key('k', 'K', :right, 1),
          KeyboardKey::make_key('l', 'L', :right, 1),
          KeyboardKey::make_key(';', ':', :right, 1),
          KeyboardKey::make_key('\'', '"', :right, 1),
          KeyboardKey::make_key(:enter, :enter, :right, 2),

          # Row 4 of 5
          KeyboardKey::make_key(:shift, :shift, :left, 5),
          KeyboardKey::make_key('z', 'Z', :left, 1),
          KeyboardKey::make_key('x', 'X', :left, 1),
          KeyboardKey::make_key('c', 'C', :left, 1),
          KeyboardKey::make_key('v', 'V', :left, 1),
          KeyboardKey::make_key('b', 'B', :left, 1),
          KeyboardKey::make_key('n', 'N', :right, 1),
          KeyboardKey::make_key('m', 'M', :right, 1),
          KeyboardKey::make_key(',', '<', :right, 1),
          KeyboardKey::make_key('.', '>', :right, 1),
          KeyboardKey::make_key('/', '?', :right, 1),
          KeyboardKey::make_key(:shift, :shift, :right, 5),

          # Row 5 of 5
          KeyboardKey::make_key(:space, :space, :left, 2),
          KeyboardKey::make_key(:space, :space, :right, 2)
      ]

      @left_keys = []
      @right_keys = []

      @keys.each { |key|
        # Separate the keys on the left side of the keyboard...
        key.keyboard_key_weight.times do
          left_keys.push(key)
        end if key.keyboard_key_section == :left

        # Separate the keys on the right side of the keyboard...
        key.keyboard_key_weight.times do
          right_keys.push(key)
        end if key.keyboard_key_section == :right
      }

      @keys.freeze
      @keys_left.freeze
      @keys_right.freeze
    end

    def get_keyboard_input
      keyboard_input = KeyboardInput.new

      left_keys = @left_keys
      right_keys = @right_keys

      keys = left_keys.zip(right_keys).flatten.compact.shuffle

      keyboard_key_evaluator = KeyboardKeyEvaluator.new

      # Take the keys until we hit a key that terminates a word...
      keyboard_input.input = keys.take_while { |key|
        !keyboard_char_ends_word?(key.keyboard_char.char)
      }.collect { |key| keyboard_key_evaluator.get_char(key) }.compact

      # Keep going until we get something...
      keyboard_input = get_keyboard_input if keyboard_input.input.empty?

      keyboard_input.is_word = LittleWeasel::Checker.instance.exists?(keyboard_input.input.to_s)

      keyboard_input
    end

    # Returns true if the character causes a word termination.
    def keyboard_char_ends_word?(char)
      return char == :tab || char == :enter || char == :space || char == '.'
    end

  end

end