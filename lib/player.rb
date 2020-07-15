class Player
  attr_accessor :color, :pieces, :captured

  def initialize(color)
    @color = color
    @pieces = []
    create_pieces
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

  def create_pieces
    8.times { @pieces << Pawn.new(color) }
    2.times do
      @pieces << Rook.new(color)
      @pieces << Bishop.new(color)
      @pieces << Knight.new(color)
    end
    @pieces << Queen.new(color)
    @pieces << King.new(color)
    @pieces.sort! { |a, b| a.class.to_s <=> b.class.to_s }
  end
end
