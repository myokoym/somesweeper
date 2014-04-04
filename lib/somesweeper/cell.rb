require "gosu"
require "somesweeper/base"
require "somesweeper/z_order"
require "somesweeper/image"

module Somesweeper
  class Cell
    include Base

    attr_reader :mine, :flag
    attr_reader :x, :y
    attr_reader :mine_count
    attr_reader :unknown

    def initialize(window,
                   x, y,
                   width, height,
                   has_mine=false,
                   x_margin=0,
                   y_margin=0)
      @window = window
      @x = x
      @y = y
      @width = width
      @height = height
      @x1 = x_margin + @x * @width
      @y1 = y_margin + @y * @height
      @x2 = @x1 + @width
      @y2 = @y1 + @height
      @unknown = true
      @frame_color = Gosu::Color::BLACK
      @background_color = Gosu::Color::WHITE
      @unknown_color = Gosu::Color::GRAY
      @highlight_color = Gosu::Color::YELLOW
      set_mine if has_mine
      @flag = nil
      @mine_count = nil
    end

    def set_mine
      @mine = Image.new(@window,
                        "@",
                        (@height * 0.9).floor)
    end

    def set_number(num)
      @mine_count = num
      @number = Image.new(@window,
                          num.to_s,
                          (@height * 0.9).floor)
    end

    def open
      @unknown = false
      @flag = nil
    end

    def close
      @unknown = true
    end

    def flag_on
      return unless @unknown
      @flag = Image.new(@window,
                        "!",
                        (@height * 0.9).floor)
    end

    def flag_off
      @flag = nil
    end

    def pointing?(x, y)
      @x1 < x && @x2 > x &&
      @y1 < y && @y2 > y
    end

    def draw
      draw_background
      draw_mine if @mine
      draw_number if @number
      draw_unknown if @unknown
      draw_flag if @flag
    end

    def draw_background
      draw_square(@window,
                  @x1, @y1,
                  @x2, @y2,
                  @background_color,
                  ZOrder::Cell)
      draw_frame(@window,
                 @x1, @y1,
                 @x2, @y2,
                 @frame_color,
                 ZOrder::Frame)
    end

    def draw_unknown
      draw_square(@window,
                  @x1, @y1,
                  @x2, @y2,
                  @unknown_color,
                  ZOrder::Cover)
    end

    def draw_highlight
      draw_square(@window,
                  @x1, @y1,
                  @x2, @y2,
                  @highlight_color,
                  ZOrder::Cell)
    end

    def draw_mine
      @mine.image.draw(@x1 + @width * 0.1,
                       @y1 + @height * 0.1,
                       ZOrder::Mine,
                       1.0,
                       1.0,
                       Gosu::Color::BLACK)
    end

    def draw_number
      @number.image.draw(@x1 + @width * 0.1,
                         @y1 + @height * 0.1,
                         ZOrder::Mine,
                         1.0,
                         1.0,
                         Gosu::Color::BLACK)
    end

    def draw_flag
      @flag.image.draw(@x1 + @width * 0.1,
                       @y1 + @height * 0.1,
                       ZOrder::Flag,
                       1.0,
                       1.0,
                       Gosu::Color::BLACK)
    end
  end
end
