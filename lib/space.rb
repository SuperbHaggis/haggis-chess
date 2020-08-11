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

  def find_adjacent(board, piece = @piece)
    @adjacent.clear
    coords = if piece.class == Knight
               Marshal.load(Marshal.dump(@piece.moveset))
             elsif piece.class == Pawn
               piece.moved ? Marshal.load(Marshal.dump(@piece.moveset)) : Marshal.load(Marshal.dump(@piece.first_move))
             else
               piece.moveset.select { |move| move.include?(1) || move.include?(-1) }
             end
    coords.map! { |move| move.zip(@coord) }.map! { |pair| pair.map { |x, y| x + y } }
    coords.select! { |coord| (0..7).include?(coord[0]) && (0..7).include?(coord[1]) }
    @adjacent = coords.map { |coord| board.find_by_coord(coord) }
  end

  def find_moves(square)
    square.children.reject! { |node| @visited.any? { |space| space.coord == node.coord } }
    square
  end

  def occupied?
    !@piece.nil?
  end
end
