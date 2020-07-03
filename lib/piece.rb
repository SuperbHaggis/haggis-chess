class Piece
  attr_accessor :color, :image, :space, :legal_moves

  def initialize(color)
    @color = color
  end
end
