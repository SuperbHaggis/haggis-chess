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
    puts ">> #{player.color.capitalize} player, choose a piece by coordinate: "
    letter_coord = gets.chomp.split('')
    @board.find_space(letter_coord[0], letter_coord[1]).piece
  end

  def choose_space(piece)
    puts ">> Choose a destination for your #{piece.class}: "
    letter_coord = gets.chomp.split('')
    piece.move(board.find_space(letter_coord[0], letter_coord[1]).coord)
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
    temp = pieces
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
end
