require "gosu"

module Somesweeper
  class Image
    attr_reader :image

    def initialize(window, text, height)
      @image = Gosu::Image.from_text(window,
                                     text,
                                     Gosu.default_font_name,
                                     height, 0, height, :center)
    end
  end
end
