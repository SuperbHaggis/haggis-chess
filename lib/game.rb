class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new('black'), Player.new('white')]
  end
end
