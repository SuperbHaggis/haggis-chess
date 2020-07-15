class Player
  attr_accessor :color, :pieces, :captured

  def initialize(color)
    @color = color
    @pieces = {
      'bishops': [],
      'knights': [],
      'pawns': [],
      'rooks': []
    }
    binding.pry
    create_pieces(color)
  end

  def take_turn(board)
    choose_space(choose_piece(board))
  end

  def choose_piece(board)
    puts ">> #{@color.capitalize} player, choose a piece by coordinate: "
    coord = gets.chomp.split('')
    board.find_space(coord[0], coord[1]).piece
  end

  def choose_space(piece)
    puts ">> Choose a destination for your #{piece.class}: "
    coord = gets.chomp.split('')
    piece.move(coord)
    piece
  end

  def create_pieces(color)
    8.times { @pieces[:pawns] << Pawn.new(color) }
    2.times do
      @pieces[:rooks] << Rook.new(color)
      @pieces[:bishops] << Bishop.new(color)
      @pieces[:knights] << Knight.new(color)
    end
    @pieces[:queen] = Queen.new(color)
    @pieces[:king] = King.new(color)
    # @pieces.sort! { |a, b| a.class.to_s <=> b.class.to_s }
  end
end
