class Piece
  attr_accessor :color, :image, :space, :moveset

  def initialize(color, space)
    @color = color
    @space = space
  end

  def move(space)
    @space = space
  end
end
