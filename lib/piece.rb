class Piece
  attr_accessor :color, :image, :space, :moveset, :previous, :path

  def initialize(color)
    @color = color
    @path = []
  end

  def move(space)
    @previous = @space
    @space = space
  end
end
