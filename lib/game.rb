class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new('black'), Player.new('white')]
  end

  def play_round
    move = @players[0].take_turn
    board[move[0]][move[1]].update(move)
  end
end
