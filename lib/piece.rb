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

  def build_tree(start, finish, coord = @start)
    find_adjacent(coord)
    @visited << coord
    return square if square == finish

    @visited.each { |square| @queue << child }
    build_tree(start, finish, @queue.shift)
  end

  def find_adjacent(space = @space)
    adjacent = @moveset.select { |move| move.include?(1) || move.include?(-1) }
    adjacent.map! { |move| move.zip(space.coord) }.map { |pair| pair.map { |x, y| x + y } }
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
