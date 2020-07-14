class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new('black'), Player.new('white')]
  end

  def play_round
    @players.each do |player|
      piece = player.take_turn
      board.spaces[piece.previous[0]][piece.previous[1]].piece = nil
      board.spaces[piece.space[0]][piece.space[1]].piece = piece
      board.refresh.display
    end
  end

  def setup
    @players.each do |player|
      pawns = player.pieces.select { |piece| piece.class == Pawn }
      player.color == 'black' ? set_pawns(pawns, 1) : set_pawns(pawns, 6)
    end
  end

  def set_pawns(pawns, row)
    @board.spaces[row].each do |space|
      space.piece = pawns.shift
      space.piece.space = space.coord
    end
  end
end
