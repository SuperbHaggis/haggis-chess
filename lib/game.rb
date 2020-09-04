class Game
  attr_accessor :board, :players, :checkmate

  def initialize
    @board = Board.new
    @players = %w[black white]
    @checkmate = false
    @board.display
  end

  def play_round(players = @players)
    players.each do |player|
      piece = choose_space(choose_piece(player), player)
      piece.previous.piece = nil
      piece.space.piece = piece
      board.display
      checkmate?(player) ? @checkmate = true : check?(player)
      break if @checkmate == true
    end
  end

  def play(players = @players)
    play_round(players) while @checkmate == false
  end

  private

  def load(input)
    piece = input[1]
    loaded_phase = 'piece' if piece.nil?
    loaded_player = input[0]
    if loaded_phase == 'piece'
      choose_space(choose_piece(loaded_player), loaded_player)
    else
      choose_space(piece, loaded_player)
    end
    loaded_player == 'black?' ? play(@players.reverse) : play
  end

  def choose_piece(player)
    piece_chosen = false
    phase = 'piece'
    puts ">> #{player.capitalize} player, choose a piece by coordinate: "
    while piece_chosen == false
      input = Hag.new.run(self, player, phase)
      load(input) if input.class == Array
      unless input.nil?
        letter_coord = input.capitalize.split('')
        if @board.find_space(letter_coord).occupied?
          piece = @board.find_space(letter_coord).piece
          piece_chosen = true if player == piece.color && piece.moveable?(@board)
        end
      end
    end
    piece
  end

  def choose_space(piece, player)
    space_chosen = false
    msg = ">> Choose a destination for your #{piece.class}: "
    puts msg
    while space_chosen == false
      input = Hag.new.run(self, player, msg, piece)
      load(input) if input.class == Array
      unless input.nil?
        letter_coord = input.capitalize.split('')
        space_chosen = true if piece.legal_move?(@board.find_space(letter_coord), @board)
      end
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
    adj.select! { |space| king.legal_move?(space, @board) }
    adj << king.space
    checkmate = if adj.size == 1
                  foes.any? { |foe| foe.moveable?(@board) && foe.legal_move?(adj[0], @board) }
                else
                  adj.map! { |move| foes.any? { |foe| foe.legal_move?(move, @board) } }
                  adj.all?(true)
                end
    puts '>> Checkmate!' if checkmate == true
    checkmate
  end
end
