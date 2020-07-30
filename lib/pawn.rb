require_relative './piece.rb'

class Pawn < Piece
  attr_accessor :first_move, :capture, :moved

  def initialize(color)
    @color = color
    @image = color == 'white' ? '♟' : '♙'
    @moveset = if @color == 'white'
                 [1, 0]
               else
                 [-1, 0]
               end
    @capture = if @color == 'white'
                 [[1, -1], [1, 1]]
               else
                 [[-1, -1], [-1, 1]]
               end
    @first_move = if @color == 'white'
                    [[1, 0], [2, 0]]
                  else
                    [[-1, 0], [-2, 0]]
                  end
    @moved = false
  end

  def move(space)
    @previous = @space
    @space = space
    @moved = true if @moved == false
  end
end
