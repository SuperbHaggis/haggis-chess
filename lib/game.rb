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
      piece = player.take_turn(@board)
      board.find_space(piece.previous[0], piece.previous[1]).piece = nil
      board.find_space(piece.space[0], piece.space[1]).piece = piece
      board.refresh.display
    end
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
    @board.spaces.each do |key, index|
      index.each do |space|
        space.piece.space = space.coord unless space.piece.nil?
      end
    end
  end
end
