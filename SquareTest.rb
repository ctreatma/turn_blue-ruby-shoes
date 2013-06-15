require "test/unit"
require "Square"

class SquareTest < Test::Unit::TestCase
  attr_reader :square
  
  def setup
    @square = Square.new
  end
  
  def test_initialize
    assert_same @square.color, Square::BLUE
  end
  
  def test_changeColor
    color = @square.color
    @square.changeColor
    assert_not_equal color, @square.color
  end
end