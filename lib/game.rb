class Game
  attr_accessor :board, :players

  def initialize
    @board = Board.new
    @players = [Player.new('black'), Player.new('white')]
    setup
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
    puts ">> #{player.color.capitalize} player, choose a piece by coordinate: "
    while piece_chosen == false
      letter_coord = gets.chomp.split('')
      if piece?(letter_coord)
        piece = @board.find_space(letter_coord).piece
        piece_chosen = true if player.color == piece.color
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

  def setup
    @players.each do |player|
      if player.color == 'black'
        player.pieces.each do |k, v|
          k == :pawns ? set_board(v, '7') : set_board(v, '8')
        end
      else
        player.pieces.each do |k, v|
          k == :pawns ? set_board(v, '2') : set_board(v, '1')
        end
      end
    end
    set_pieces
  end

  def set_board(pieces, row)
    temp = pieces.class == Array ? pieces.map(&:clone) : pieces
    @board.spaces[row].each do |space|
      if temp.class == Array
        if temp[0].class == Bishop
          space.piece = temp.shift if space.letter == 'C' && space.piece.nil?
          space.piece = temp.shift if space.letter == 'F'
        elsif temp[0].class == Knight
          space.piece = temp.shift if space.letter == 'B' && space.piece.nil?
          space.piece = temp.shift if space.letter == 'G'
        elsif temp[0].class == Rook
          space.piece = temp.shift if space.letter == 'A' && space.piece.nil?
          space.piece = temp.shift if space.letter == 'H'
        else
          space.piece = temp.shift
        end
      else
        space.piece = temp if temp.class == King && space.letter == 'E'
        space.piece = temp if temp.class == Queen && space.letter == 'D'
      end
    end
  end

  def set_pieces
    @board.spaces.each do |_k, row|
      row.each do |space|
        space.piece.space = space.coord unless space.piece.nil?
      end
    end
  end

  def piece?(letter_coord)
    if @board.find_space(letter_coord).piece.nil?
      false
    else
      true
    end
  end

  def right_color?(player, piece)
    player.color == piece.color
  end

  def legal_move?(space, piece)
    if space.piece.nil?
      true if piece.moveset.include?(piece.space.zip(space.coord).map { |x, y| y - x })
    else
      space.piece.color != piece.color
    end
  end
end
