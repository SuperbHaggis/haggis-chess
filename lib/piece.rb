class Piece
  attr_accessor :color, :image, :space, :moveset, :previous

  def initialize(color)
    @color = color
    @path = []
  end

  def find_path(space)
    
  end

  def move(space)
    @previous = @space
    @space = space
  end
end
