class Space
  attr_accessor :coord, :color, :image, :default_image, :piece, :letter,
                :adjacent

  def initialize(color, coord)
    @color = color
    @coord = coord
    @default_image = @color == 'white' ? '■' : '□'
    @image = @default_image
    @piece = nil
    @adjacent = []
  end

  def update
    @image = @piece.nil? ? @default_image : @piece.image
  end

  def occupied?
    !@piece.nil?
  end

  def find_adjacent(piece, board)
    # find adjacent coords
    coords = piece.moveset.select { |move| move.include?(1) || move.include?(-1) }
    coords.map! { |move| move.zip(@coord) }.map! { |pair| pair.map { |x, y| x + y } }
    coords.select! { |coord| (0..7).include?(coord[0]) && (0..7).include?(coord[1]) }
    @adjacent = coords.map { |coord| board.find_by_coord(coord) }
    binding.pry
  end

  def find_moves(square)
    square.children.reject! { |node| @visited.any? { |space| space.coord == node.coord } }
    square
  end
end
