require_relative './piece.rb'

class Pawn < Piece
  
  def initialize(color)
    @color = color
    @image = color == 'white' ? '♟' : '♙'
    @moveset = if @color == 'white'
                 [[1, 0], [2, 0], [1, -1], [1, 1], [2, -1], [2, 1]]
               else
                 [[-1, 0], [-2, 0], [-1, -1], [-1, 1], [-2, -1], [-2, 1]]
               end
  end
end
