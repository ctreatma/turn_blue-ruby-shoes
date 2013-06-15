require "test/unit"
require "Board"

class BoardTest < Test::Unit::TestCase
  attr_reader :board
  
  def setup
    @board = Board.new(1,1)
  end
  
  def test_clickSquare
    color = @board.squares[0][0].color
    @board.clickSquare(0,0)
    assert_not_equal color, @board.squares[0][0].color
  end

  def test_solved
    assert !@board.solved?
    @board.clickSquare(0,0)
    assert @board.solved?
  end
end