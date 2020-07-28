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
      board.find_coord(piece.previous).piece = nil
      board.find_coord(piece.space).piece = piece
      board.display
    end
  end

  private

  def choose_piece(player)
    piece_chosen = false
    puts ">> #{player.capitalize} player, choose a piece by coordinate: "
    while piece_chosen == false
      letter_coord = gets.chomp.split('')
      if occupied?(letter_coord)
        piece = @board.find_space(letter_coord).piece
        piece_chosen = true if player == piece.color
      end
    end
    piece
  end

  def choose_space(piece)
    space_chosen = false
    puts ">> Choose a destination for your #{piece.class}: "
    while space_chosen == false
      letter_coord = gets.chomp.split('')
      space_chosen = true if legal_move?(@board.find_space(letter_coord), piece)
    end
    piece.move(@board.find_space(letter_coord).coord)
    piece
  end

  def occupied?(letter_coord)
    if @board.find_space(letter_coord).piece.nil?
      false
    else
      true
    end
  end

  def right_color?(player, piece)
    player == piece.color
  end

  def legal_move?(space, piece)
    if space.piece.nil?
      true if piece.moveset.include?(piece.space.zip(space.coord).map { |x, y| y - x })
    else
      space.piece.color != piece.color && piece.moveset.include?(piece.space.zip(space.coord).map { |x, y| y - x })
    end
  end
end
