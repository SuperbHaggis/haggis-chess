class King < Piece
  def initialize(color)
    @color = color
    @image = color == 'white' ? '♔' : '♚'
  end
end
