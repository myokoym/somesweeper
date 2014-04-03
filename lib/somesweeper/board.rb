require "gosu"
require "somesweeper/base"
require "somesweeper/z_order"
require "somesweeper/cell"

module Somesweeper
  class Board
    include Base

    def initialize(window, width, height)
      @window = window
      @width = width
      @height = height
      @cells = []
      create_cells
      set_numbers
    end

    def draw
      draw_background
      @cells.each do |cell|
        cell.draw
        #if cell.pointing?(@window.mouse_x, @window.mouse_y)
        #  cell.draw_highlight
        #end
      end
    end

    def click
      @cells.each do |cell|
        if cell.pointing?(@window.mouse_x, @window.mouse_y)
          return cell
        end
      end
      nil
    end

    def open_all
      @cells.each {|cell| cell.open }
    end

    def reset
      @cells = []
      create_cells
      set_numbers
      @cells.each {|cell| cell.close }
    end

    private
    def draw_background
      draw_square(@window,
                  0, 0,
                  @width, @height,
                  Gosu::Color::BLACK,
                  ZOrder::Background)
    end

    def create_cells
      width = 29
      height = 29
      x_margin = @width % width
      y_margin = @height % height
      @num_of_column = (@width - x_margin) / width
      @num_of_row = (@height - y_margin) / height
      0.upto(@num_of_column - 1) do |x|
        0.upto(@num_of_row - 1) do |y|
          @cells << Cell.new(@window,
                             x, y,
                             width, height,
                             Random.rand(5) == 0,
                             x_margin / 2,
                             y_margin / 2)
        end
      end
    end

    def set_numbers
      cell_hash = {}
      @cells.each do |cell|
        key = [cell.x, cell.y]
        has_mine = cell.mine ? true : false
        cell_hash[key] = has_mine
      end
      @cells.each do |cell|
        next if cell.mine
        count = 0
        [
          [cell.x - 1, cell.y - 1],
          [cell.x    , cell.y - 1],
          [cell.x + 1, cell.y - 1],
          [cell.x - 1, cell.y    ],
          [cell.x    , cell.y    ],
          [cell.x + 1, cell.y    ],
          [cell.x - 1, cell.y + 1],
          [cell.x    , cell.y + 1],
          [cell.x + 1, cell.y + 1],
        ].each do |key|
          count += 1 if cell_hash[key]
        end
        cell.set_number(count)
      end
    end
  end
end
