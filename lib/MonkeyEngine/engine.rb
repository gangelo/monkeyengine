require 'observer'
require 'singleton'

require "MonkeyEngine/version"

module MonkeyEngine

  # Engine class.
  class Engine
    include Singleton
    include Observable

    private
    def initialize
    end

    def do_action(action)
      # TODO: Update database for monkey with action detail
      # TODO: Call observer to notify of action update.
    end
  end
end
