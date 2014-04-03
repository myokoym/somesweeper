require "gosu"
require "somesweeper/base"
require "somesweeper/z_order"
require "somesweeper/board"

module Somesweeper
  class Window < Gosu::Window
    def initialize(width=200, height=200)
      super(width, height, false)
      self.caption = "Somesweeper"
      @board = Board.new(self, width, height)
    end

    def update
    end

    def draw
      @board.draw
    end

    def button_down(id)
      case id
      when Gosu::MsLeft
        clicked_cell = @board.click
        return unless clicked_cell
        return if clicked_cell.flag
        clicked_cell.open
        if clicked_cell.mine
          @board.open_all
        end
      when Gosu::MsRight
        clicked_cell = @board.click
        return unless clicked_cell
        if clicked_cell.flag
          clicked_cell.flag_off
        else
          clicked_cell.flag_on
        end
      when Gosu::KbR
        @board.reset
      when Gosu::KbEscape
        close
      end
    end

    def needs_cursor?
      true
    end
  end
end
