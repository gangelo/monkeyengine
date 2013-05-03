require 'test/unit/assertions'

module MonkeyEngine
  module Exceptions
    class InvalidArgumentValueException < ArgumentError;
    end

    class InvalidArgumentTypeException < ArgumentError;
    end

    class NilArgumentException < ArgumentError;
    end
  end
end