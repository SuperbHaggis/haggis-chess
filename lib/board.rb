class Board
  attr_accessor :spaces, :pieces, :queue

  def initialize
    generate
    @pieces = []
    @queue = []
    create_pieces('black')
    create_pieces('white')
    setup
  end

  def display
    refresh
    @spaces.each { |k, v| puts "#{k} #{v.map(&:image).join(' ')}" }
    puts '  ' + ('A'..'H').to_a.join(' ')
  end

  # Search methods
  def find_space(coord)
    @spaces[coord[1]].find { |space| space.letter == coord[0] }
  end

  def find_by_coord(coord)
    space_row = @spaces.find { |_k, v| v.find { |s| s.coord == coord } }
    space_row.shift
    space_row[0].find { |space| space.coord == coord }
  end

  # test
  def clear_path?(piece, space)
    build_tree(piece, space) == space
  end

  def build_tree(piece, finish, space = piece.space)
    return space if space == finish

    binding.pry
    space.find_adjacent(piece)
    piece.visited << space
    piece.visited.each { |square| @queue << square }
    build_tree(piece, finish, @queue.shift)
  end

  private

  def refresh
    @spaces.each { |_k, row| row.each(&:update) }
  end

  # grid and Space creation
  def create_grid
    grid = Array.new(8) { Array.new(8) { [] } }
    grid.map! do |row|
      if grid.index(row).even?
        row.each { |space| row.index(space).even? ? space << 'white' : space << 'black' }
      else
        row.each { |space| row.index(space).even? ? space << 'black' : space << 'white' }
      end
      row.map! do |space|
        space << [grid.index(row), row.index(space)]
      end
    end
    grid.reverse
  end

  def create_spaces
    spaces = create_grid.map { |row| row.map { |space| Space.new(space[0], space[1]) } }
    spaces.each do |row|
      letters = ('A'..'H').to_a
      row.each { |space| space.letter = letters.shift }
    end
    spaces
  end

  def generate
    @spaces = {}
    spaces = create_spaces
    ('1'..'8').to_a.reverse.each do |num|
      @spaces[num] = spaces.shift
    end
  end

  # Piece creation and setup
  def create_pieces(color)
    8.times { @pieces << Pawn.new(color) }
    2.times do
      @pieces << Rook.new(color)
      @pieces << Bishop.new(color)
      @pieces << Knight.new(color)
    end
    @pieces << Queen.new(color)
    @pieces << King.new(color)
  end

  def setup
    @pieces.each do |piece|
      if piece.color == 'black'
        piece.class == Pawn ? set_board(piece, '7') : set_board(piece, '8')
      else
        piece.class == Pawn ? set_board(piece, '2') : set_board(piece, '1')
      end
    end
    set_pieces
  end

  def set_board(piece, row)
    spaces[row].each do |space|
      if piece.class == Bishop
        space.piece = piece if space.letter == 'C' && space.piece.nil?
        space.piece = piece if space.letter == 'F'
      elsif piece.class == Knight
        space.piece = piece if space.letter == 'B' && space.piece.nil?
        space.piece = piece if space.letter == 'G'
      elsif piece.class == Rook
        space.piece = piece if space.letter == 'A' && space.piece.nil?
        space.piece = piece if space.letter == 'H'
      elsif piece.class == King
        space.piece = piece if space.letter == 'E'
      elsif piece.class == Queen
        space.piece = piece if space.letter == 'D'
      else
        space.piece = piece
      end
    end
  end

  def set_pieces
    spaces.each do |_k, row|
      row.each do |space|
        space.piece.space = space unless space.piece.nil?
      end
    end
  end
end
