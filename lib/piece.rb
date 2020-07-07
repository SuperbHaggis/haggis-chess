class Piece
  attr_accessor :color, :image, :space, :moveset, :previous

  def initialize(color, space)
    @color = color
    @space = space
  end

  def move(space)
    @previous = @space
    @space = space
  end
end
