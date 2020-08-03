class Piece
  attr_accessor :color, :image, :space, :moveset, :previous, :adjacent,
                :visited, :queue

  def initialize(color)
    @color = color
    @adjacent = find_adjacent
    @visited = []
    @queue = []
  end

  def move(space)
    @previous = @space
    @space = space
  end
end