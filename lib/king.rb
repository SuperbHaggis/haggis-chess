require_relative './piece.rb'

class King < Piece
  def initialize(color)
    @color = color
    @image = color == 'white' ? '♚' : '♔'
    @moveset = [
      [1, 0], [1, 1], [0, 1], [-1, 1],
      [-1, 0], [-1, -1], [0, -1], [1, -1]
    ]
    @path = []
  end
end
