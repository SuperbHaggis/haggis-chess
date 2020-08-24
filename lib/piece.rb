class Piece
  attr_accessor :color, :image, :moveset, :space, :previous, :path

  def initialize(color)
    @color = color
    @path = []
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

  def legal_move?(space, board)
    move = @space.coord.zip(space.coord).map { |x, y| y - x }
    if space.piece.nil? || space.piece.color != @color
      true if @moveset.include?(move) && board.clear_path?(self, space)
    else
      false
    end
  end
end
