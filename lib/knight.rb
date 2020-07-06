class Knight < Piece
  def initialize(color)
    @color = color
    @image = color == 'white' ? '♘' : '♞'
    @moveset = [
      [1, 2], [-1, -2], [2, 1], [-2, -1], 
      [1, -2], [2, -1], [-1, -2], [-2, -1]
    ]
  end
end
