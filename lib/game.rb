class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = %w[black white]
    @board.display
  end

  def play_round
    @players.each do |player|
      piece = choose_space(choose_piece(player))
      board.find_by_coord(piece.previous.coord).piece = nil
      board.find_by_coord(piece.space.coord).piece = piece
      board.display
    end
  end

  private

  def choose_piece(player)
    piece_chosen = false
    puts ">> #{player.capitalize} player, choose a piece by coordinate: "
    while piece_chosen == false
      letter_coord = gets.chomp.capitalize.split('')
      if board.find_space(letter_coord).occupied?
        piece = @board.find_space(letter_coord).piece
        piece_chosen = true if player == piece.color && piece.moveable?(@board)
      end
    end
    piece
  end

  def choose_space(piece)
    space_chosen = false
    puts ">> Choose a destination for your #{piece.class}: "
    while space_chosen == false
      letter_coord = gets.chomp.capitalize.split('')
      piece.legal_move?(@board.find_space(letter_coord), board)
      space_chosen = true if piece.legal_move?(@board.find_space(letter_coord), board)
    end
    piece.move(@board.find_space(letter_coord))
    piece
  end
end
