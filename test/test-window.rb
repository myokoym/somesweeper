require "somesweeper"

class WindowTest < Test::Unit::TestCase
  def setup
    @window = Somesweeper::Window.new
  end

  def test_init
    assert_not_nil(@window)
  end
end
