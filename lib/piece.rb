class Piece
  attr_accessor :color, :image, :moveset, :space, :previous, :visited

  def initialize(color)
    @color = color
    @visited = []
  end

  def move(space)
    @previous = @space
    @space = space
  end

  def moveable?(board)
    adjacent = @space.find_adjacent(board)
    if adjacent.all?(&:occupied?)
      return adjacent.any? { |space| space.piece.color != @color }
    end

    adjacent.any? { |space| !space.occupied? }
  end

  def legal_move?(space)
    move = @space.coord.zip(space.coord).map { |x, y| y - x }
    if space.piece.nil?
      true if @moveset.include?(move)
    elsif space.piece.color != @color && @moveset.include?(move)
      true
    else
      false
    end
  end
end
