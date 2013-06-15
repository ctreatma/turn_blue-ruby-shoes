require "Board"

class TurnBlue
  BOARD_SIZE = 8
  SQUARE_SIZE = 35 #pixels
  LOSS_MARGIN = 5
  MAX_LEVEL = 32
  WINDOW_WIDTH = SQUARE_SIZE * (BOARD_SIZE + 2)
  WINDOW_HEIGHT = SQUARE_SIZE * (BOARD_SIZE + 3)
  attr_accessor :board, :clicks, :level, :gameOver
  
  def initialize
    $turnBlue = self
    startNewGame
  end
  
  def startNewGame
    @gameOver = false
    @level = 1
    @clicks = 0
    @board = Board.new(BOARD_SIZE, @level)
    draw
  end
  
  def handleClick(x,y)
    #see if click occurred inside the game board
    if(x < SQUARE_SIZE * (BOARD_SIZE + 1) &&
      x > SQUARE_SIZE &&
      y < SQUARE_SIZE * (BOARD_SIZE + 1) &&
      y > SQUARE_SIZE && !gameOver)
      #figure out which square was clicked
      row = x/SQUARE_SIZE - 1
      column = y/SQUARE_SIZE - 1
      clickSquare(row, column)
    end
  end
  
  def clickSquare(x,y)
    @clicks = @clicks + 1
    @board.clickSquare(x,y)
    draw
    if @board.solved?
      if @level < MAX_LEVEL
        @level = level + 1
        @clicks = 0;
        $app.alert("Congratulations!  You made it to level #{@level}");
        @board = Board.new(BOARD_SIZE, @level)
        draw
      else
        @gameOver = true
        $app.alert("Congratulations!  You beat the game!")
      end
    elsif @clicks >= @level + LOSS_MARGIN  
      @gameOver = true
      $app.alert("Game over!")
    end
  end
  
  #draw the window
  def draw
    $app.clear
    
    #draw the game board
    drawBoard
    
    #draw the current level
    curLevel = $app.para("Level: #{@level}")
    
    #provide a New Game button
    newGame = $app.button "New Game" do
      $turnBlue.startNewGame
    end
    newGame.move((SQUARE_SIZE * (BOARD_SIZE/2)) - 5,0)
    
    #draw the current click count
    curClicks = $app.para("Clicks: #{@clicks}")
    curClicks.move(SQUARE_SIZE * (BOARD_SIZE) - 5,0)
  end

  #draw the game board
  def drawBoard
    for i in (0...@board.squares.length)
      for j in (0...@board.squares.length)
        drawSquare(@board.squares[i][j].color, i, j)
      end
    end
  end

  #draw a square in the supplied position
  #with the supplied color (either red or blue)
  def drawSquare(color, x_position, y_position)
    if (color == Square::BLUE)
      $app.fill($app.rgb(0,0,150))
    else
      $app.fill($app.rgb(150,0,0))
    end
    $app.stroke($app.rgb(255,255,255))
    $app.rect((x_position + 1) * SQUARE_SIZE,
              (y_position + 1) * SQUARE_SIZE, 
              SQUARE_SIZE)
  end
end

Shoes.app(
  :title => "TurnBlue", 
  :width => TurnBlue::WINDOW_WIDTH, 
  :height => TurnBlue::WINDOW_HEIGHT, 
  :resizable => false
  ) do
    $app = self
    TurnBlue.new
    
    click do |btn, x, y|
      $turnBlue.handleClick(x,y)
    end
  end
