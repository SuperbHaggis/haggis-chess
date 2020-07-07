class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new('black'), Player.new('white')]
  end

  def play_round
    @players.each do |player|
      piece = player.take_turn
      board[piece.previous[0]][piece.previous[1]].update
      board[piece.space[0]][piece.space[1]].update(piece.image)
      board.display
    end
  end
end
