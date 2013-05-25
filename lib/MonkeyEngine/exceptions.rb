require 'test/unit/assertions'

module MonkeyEngine
  module Exceptions
    class InvalidArgumentValueException < ArgumentError;
    end

    class InvalidArgumentTypeException < ArgumentError;
    end

    class NilArgumentException < ArgumentError;
    end

    # The object must be unique.
    class UniqueObjectException < ArgumentError;
    end

    class InvalidOperationException < ArgumentError;
    end
  end
end