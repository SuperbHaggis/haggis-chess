class Board
  attr_accessor :spaces, :pieces

  def initialize
    @spaces = Hash.new
    spaces = create_spaces
    ('1'..'8').to_a.reverse.each do |num|
      @spaces[num] = spaces.shift
    end
    @pieces = {
      white: {
        bishops: [],
        knights: [],
        pawns: [],
        rooks: []
      },
      black: {
        bishops: [],
        knights: [],
        pawns: [],
        rooks: []
      }
    }
    create_pieces('black')
    create_pieces('white')
    setup
  end

  def display
    refresh
    @spaces.each { |k, v| puts "#{k} #{v.map(&:image).join(' ')}" }
    puts '  ' + ('A'..'H').to_a.join(' ')
  end

  def find_space(coord)
    @spaces[coord[1]].find { |space| space.letter == coord[0] }
  end

  def find_coord(coord)
    space_row = @spaces.find { |_k, v| v.find { |s| s.coord == coord } }
    space_row.shift
    space_row[0].find { |space| space.coord == coord }
  end

  private

  def refresh
    @spaces.each { |_k, row| row.each(&:update) }
  end

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

  def create_pieces(color)
    colorsym = color.to_sym
    8.times { @pieces[colorsym][:pawns] << Pawn.new(color) }
    2.times do
      @pieces[colorsym][:rooks] << Rook.new(color)
      @pieces[colorsym][:bishops] << Bishop.new(color)
      @pieces[colorsym][:knights] << Knight.new(color)
    end
    @pieces[colorsym][:queen] = Queen.new(color)
    @pieces[colorsym][:king] = King.new(color)
  end

  def setup
    @pieces.each do |color, type|
      if color == :black
        type.each do |k, v|
          k == :pawns ? set_board(v, '7') : set_board(v, '8')
        end
      else
        type.each do |k, v|
          k == :pawns ? set_board(v, '2') : set_board(v, '1')
        end
      end
    end
    set_pieces
  end

  def set_board(pieces, row)
    temp = pieces.class == Array ? pieces.map(&:clone) : pieces
    spaces[row].each do |space|
      if temp.class == Array
        if temp[0].class == Bishop
          space.piece = temp.shift if space.letter == 'C' && space.piece.nil?
          space.piece = temp.shift if space.letter == 'F'
        elsif temp[0].class == Knight
          space.piece = temp.shift if space.letter == 'B' && space.piece.nil?
          space.piece = temp.shift if space.letter == 'G'
        elsif temp[0].class == Rook
          space.piece = temp.shift if space.letter == 'A' && space.piece.nil?
          space.piece = temp.shift if space.letter == 'H'
        else
          space.piece = temp.shift
        end
      else
        space.piece = temp if temp.class == King && space.letter == 'E'
        space.piece = temp if temp.class == Queen && space.letter == 'D'
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
