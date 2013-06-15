class Square
  BLUE = 'blue'
  RED = 'red'
  attr_accessor :color
  
  def initialize
    @color = BLUE
  end
  
  def changeColor
    if (@color == BLUE)
      @color = RED
    else
      @color = BLUE
    end
  end
end