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
        set_board(player.pieces[:bishops], '8')
        set_board(player.pieces[:knights], '8')
        set_board(player.pieces[:pawns], '7')
        set_board(player.pieces[:rooks], '8')
        set_board(player.pieces[:king], '8')
        set_board(player.pieces[:queen], '8')
      else
        set_board(player.pieces[:bishops], '1')
        set_board(player.pieces[:knights], '1')
        set_board(player.pieces[:pawns], '2')
        set_board(player.pieces[:rooks], '1')
        set_board(player.pieces[:king], '1')
        set_board(player.pieces[:queen], '1')
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
