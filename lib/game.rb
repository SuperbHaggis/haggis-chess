class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new('black'), Player.new('white')]
    setup
    @board.display
  end

  def play_round
    @players.each do |player|
      piece = choose_space(choose_piece(player))
      board.find_coord(piece.previous).piece = nil
      board.find_coord(piece.space).piece = piece
      board.display
    end
  end

  private

  def choose_piece(player)
    puts ">> #{player.color.capitalize} player, choose a piece by coordinate: "
    letter_coord = gets.chomp.split('')
    @board.find_space(letter_coord[0], letter_coord[1]).piece
  end

  def choose_space(piece)
    puts ">> Choose a destination for your #{piece.class}: "
    letter_coord = gets.chomp.split('')
    piece.move(board.find_space(letter_coord[0], letter_coord[1]).coord)
    piece
  end

  def setup
    @players.each do |player|
      if player.color == 'black'
        set_bishops(player.pieces[:bishops], '8')
        set_knights(player.pieces[:knights], '8')
        set_pawns(player.pieces[:pawns], '7')
        set_rooks(player.pieces[:rooks], '8')
        set_king_queen(player.pieces[:king], player.pieces[:queen], '8')
      else
        set_bishops(player.pieces[:bishops], '1')
        set_knights(player.pieces[:knights], '1')
        set_pawns(player.pieces[:pawns], '2')
        set_rooks(player.pieces[:rooks], '1')
        set_king_queen(player.pieces[:king], player.pieces[:queen], '1')
      end
    end
    set_pieces
  end

  def set_bishops(bishops, row)
    bishops_temp = bishops
    @board.spaces[row].each do |space|
      space.piece = bishops_temp.shift if space.letter == 'C' && space.piece.nil?
      space.piece = bishops_temp.shift if space.letter == 'F'
    end
  end

  def set_knights(knights, row)
    knights_temp = knights
    @board.spaces[row].each do |space|
      space.piece = knights_temp.shift if space.letter == 'B' && space.piece.nil?
      space.piece = knights_temp.shift if space.letter == 'G'
    end
  end

  def set_rooks(rooks, row)
    rooks_temp = rooks
    @board.spaces[row].each do |space|
      space.piece = rooks_temp.shift if space.letter == 'A' && space.piece.nil?
      space.piece = rooks_temp.shift if space.letter == 'H'
    end
  end

  def set_pawns(pawns, row)
    pawns_temp = pawns
    @board.spaces[row].each do |space|
      space.piece = pawns_temp.shift
    end
  end

  def set_king_queen(king, queen, row)
    @board.spaces[row].each do |space|
      space.piece = king if space.letter == 'E'
      space.piece = queen if space.letter == 'D'
    end
  end

  def set_pieces
    @board.spaces.each do |_k, row|
      row.each do |space|
        space.piece.space = space.coord unless space.piece.nil?
      end
    end
  end
end
