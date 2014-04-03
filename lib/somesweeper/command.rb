require "somesweeper/window"

module Somesweeper
  class Command
    class << self
      def run
        window = Window.new
        window.show
      end
    end
  end
end
