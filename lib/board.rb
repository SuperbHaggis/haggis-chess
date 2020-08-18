class Board
  attr_accessor :spaces, :pieces, :queue, :searched, :arrays

  def initialize
    generate
    @pieces = []
    @arrays = [@queue = [], @searched = []]
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

  def clear_path?(piece, finish)
    build_path(piece, build_tree(piece, finish))
    piece.path.reject! { |space| space == finish }
    boolean = piece.path.none? { |space| !space.piece.nil? }
    @arrays.each(&:clear)
    piece.path.clear
    boolean
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
        piece.class == Pawn ? set_pawn(piece, '7') : set_board(piece, '8')
      else
        piece.class == Pawn ? set_pawn(piece, '2') : set_board(piece, '1')
      end
    end
  end

  def set_board(piece, row)
    if piece.class == Bishop
      space = find_space(['C', row]).piece.nil? ? find_space(['C', row]) : find_space(['F', row])
    elsif piece.class == Knight
      space = find_space(['B', row]).piece.nil? ? find_space(['B', row]) : find_space(['G', row])
    elsif piece.class == Rook
      space = find_space(['A', row]).piece.nil? ? find_space(['A', row]) : find_space(['H', row])
    elsif piece.class == King
      space = find_space(['E', row])
    else
      space = find_space(['D', row])
    end
    space.piece = piece
    piece.space = space
  end

  def set_pawn(piece, row)
    @spaces[row].map do |space|
      if space.piece.nil?
        space.piece = piece
        space.piece.space = space
        break
      end
    end
  end

  # creation of search tree
  def build_tree(piece, finish, space = piece.space, board = self)
    piece.class == Queen ? space.find_adjacent_queen(board, finish, piece) : space.find_adjacent(board, piece)
    @searched << space
    return space if space == finish

    space.adjacent.each { |square| @queue << square }
    build_tree(piece, finish, @queue.shift)
  end

  def build_path(piece, space)
    return if piece.space == space

    piece.path << space
    parent = @searched.select { |square| square.adjacent.include?(space) }
    build_path(piece, parent[0])
  end
end
