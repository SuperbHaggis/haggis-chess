class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new('black'), Player.new('white')]
  end

  def play_round
    piece = @players[0].take_turn
    board[move.space[0]][move.space[1]].update(piece.image)
    board.display
    piece = @players[1].take_turn
    board[move.space[0]][move.space[1]].update(piece.image)
    board.display
  end
end
