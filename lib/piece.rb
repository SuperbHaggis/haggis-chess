class Piece
  attr_accessor :color, :image, :space, :moveset, :previous

  def initialize(color)
    @color = color
  end

  def move(space)
    @previous = @space
    @space = space
  end
end
