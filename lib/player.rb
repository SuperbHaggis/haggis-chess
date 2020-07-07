class Player
  attr_accessor :color, :pieces, :captured

  def initialize(color)
    @color = color
    @pieces = []
    8.times { @pieces << Pawn.new(color) }
    2.times do
      @pieces << Rook.new(color)
      @pieces << Bishop.new(color)
      @pieces << Knight.new(color)
    end
    @pieces << Queen.new(color)
    @pieces << King.new(color)
  end

  def take_turn(board)
    puts ">> #{@color.capitalize} player, choose a piece by coordinate: "
    selected_piece = gets.chomp.split('')
    selected_piece = @pieces.select { |piece| }
    puts ">> Choose a destination for your #{piece.class}: "
    destination = gets.chomp.split('')
    piece.move(destination)
  end
end
