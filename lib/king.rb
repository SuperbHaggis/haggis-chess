class King < Piece
  def initialize(color)
    @color = color
    @image = color == 'white' ? '♚' : '♔'
    @moveset = [
      [1, 0], [1, 1], [0, 1], [-1, 1],
      [-1, 0], [-1, -1], [0, -1], [1, -1]
    ]
  end
end
