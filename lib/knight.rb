require_relative './piece.rb'

class Knight < Piece
  def initialize(color)
    @color = color
    @image = color == 'white' ? '♞' : '♘'
    @moveset = [
      [1, 2], [-1, -2], [2, 1], [-2, -1],
      [1, -2], [2, -1], [-1, 2], [-2, 1]
    ]
    @path = []
  end
end
