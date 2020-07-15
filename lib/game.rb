class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new('black'), Player.new('white')]
  end

  def play_round
    @players.each do |player|
      piece = player.take_turn
      prev = board.find_space(piece.previous[1], piece.previous[0])
      current = board.find_space(piece.space[1], piece.space[0])
      prev.piece = nil
      current.piece = piece
      board.display
    end
  end
end
