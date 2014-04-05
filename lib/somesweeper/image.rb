require "gosu"

module Somesweeper
  class Image
    attr_reader :image

    def initialize(window, text, height)
      @window = window
      @height = height
      @image = Gosu::Image.from_text(@window,
                                     text,
                                     Gosu.default_font_name,
                                     @height, 0, @height, :center)
    end

    def set_image_file(path)
      @image = Gosu::Image.new(@window,
                               path,
                               false)
    end
  end
end
