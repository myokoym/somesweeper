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
        open_around(clicked_cell) if clicked_cell.mine_count == 0
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

    private
    def open_around(cell)
      [
        [cell.x - 1, cell.y - 1],
        [cell.x    , cell.y - 1],
        [cell.x + 1, cell.y - 1],
        [cell.x - 1, cell.y    ],
        [cell.x + 1, cell.y    ],
        [cell.x - 1, cell.y + 1],
        [cell.x    , cell.y + 1],
        [cell.x + 1, cell.y + 1],
      ].each do |key|
        cell = @board.cell_hash[key]
        if cell && cell.unknown
          cell.open
          open_around(cell) if cell.mine_count == 0
        end
      end
    end
  end
end
