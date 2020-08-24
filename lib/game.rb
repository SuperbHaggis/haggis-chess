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
      piece.previous.piece = nil
      piece.space.piece = piece
      board.display
      check?(player) unless checkmate?(player)
    end
  end

  private

  def choose_piece(player)
    piece_chosen = false
    puts ">> #{player.capitalize} player, choose a piece by coordinate: "
    while piece_chosen == false
      letter_coord = gets.chomp.capitalize.split('')
      if @board.find_space(letter_coord).occupied?
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
      space_chosen = true if piece.legal_move?(@board.find_space(letter_coord), @board)
    end
    piece.move(@board.find_space(letter_coord))
    piece
  end

  def check?(color)
    king = @board.pieces.find { |p| p.class == King && p.color != color }
    foes = @board.pieces.select { |p2| p2.color == color }
    check = foes.any? { |foe| foe.legal_move?(king.space, @board) }
    puts '>> Check!' if check == true
    check
  end

  def checkmate?(color)
    king = @board.pieces.find { |p| p.class == King && p.color != color }
    foes = @board.pieces.select { |p2| p2.color == color }
    adj = king.space.find_adjacent(@board)
    binding.pry
    adj.select! { |space| king.legal_move?(space, @board) }
    adj << king.space
    binding.pry
    checkmate = if adj.size == 1
                  foes.any? { |foe| foe.moveable? && foe.legal_move?(adj[0], @board) }
                else
                  adj.map! { |move| foes.any? { |foe| foe.legal_move?(move, @board) } }
                  adj.all?(true)
                end
    puts '>> Checkmate!' if checkmate == true
    checkmate
  end
end
