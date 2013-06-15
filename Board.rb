require "Square"

class Board
  attr_accessor :squares
  
  def initialize(size, level)
    @squares = Array.new(size){Array.new(size){nil}}
    
    @squares = @squares.map do
      |row| row.map do
        |square| Square.new
      end
    end
    
    #Click random squares to set up the board for play
    clicked = Array.new;
    while (clicked.length < level)
      row = rand(@squares.length)
      column = rand(@squares.length)
      target = @squares[row][column]
      clicked.each do |square|
        target = nil if square == target
      end
      if !target.nil?
        clickSquare(row, column)
        clicked.push(target)
      end
  	end
  end
  
  def clickSquare(x,y)
    #Change the color of the clicked square
    @squares[x][y].changeColor;
    #Click the squares above and below
    @squares[x-1][y].changeColor if (x > 0)
    @squares[x+1][y].changeColor if (x < @squares.length-1)
    #Click the squares to the left and right
    @squares[x][y-1].changeColor if (y > 0)
    @squares[x][y+1].changeColor if (y < @squares.length-1)
  end
  
  def solved?
    #Check all squares to see if the level is completed
    @squares.each do |row|
      row.each do |square|
        return false unless (square.color == Square::BLUE)
      end
    end
    return true;
  end
end
