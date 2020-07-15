class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new('black'), Player.new('white')]
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
        set_pawns(player.pieces[:pawns], '7')
      else
        set_pawns(player.pieces[:pawns], '2')
      end
    end
  end

  # pawns = game.players[0].pieces.select {|p| p.class == Pawn}
  def set_pawns(pawns, row)
    pawns_temp = pawns
    @board.spaces[row].each do |space|
      space.piece = pawns_temp.shift
      space.piece.space = space.coord
    end
  end
end
