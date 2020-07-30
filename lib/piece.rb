class Piece
  attr_accessor :color, :image, :space, :moveset, :previous

  def initialize(color)
    @color = color
    @path = []
  end

  def move(space)
    @previous = @space
    @space = space
  end

  def find_adjacent
    adjacent = @moveset.select { |move| move.include?(1) || move.include?(-1) }
    binding.pry
    adjacent.map! { |move| move.zip(@space) }.map { |pair| pair.map { |x, y| x + y } }
  end
end
