require_relative './piece.rb'

class Rook < Piece
  def initialize(color)
    @color = color
    @image = color == 'white' ? '♜' : '♖'
    @moveset = [
      [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
      [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
      [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
      [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0,-6], [0, -7],
    ]
    @path = []
  end
end
