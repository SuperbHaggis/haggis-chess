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

  def take_turn
    puts ">> #{@color.capitalize} player, choose a piece by coordinate: "
    coordinate = gets.chomp.split('')
    selected_piece = @pieces.select { |piece| piece.space == coordinate }
    puts ">> Choose a destination for your #{selected_piece.class}: "
    destination = gets.chomp.split('')
    selected_piece.move(destination)
    selected_piece
  end
end
