class Player
  attr_accessor :color, :pieces

  def initialize(color)
    @color = color
    @pieces = [
      pawns: Array.new(7) { Pawn.new(color) },
      rooks: Array.new(2) { Rook.new(color) },
      bishops: Array.new(2) { Bishop.new(color) },
      knights: Array.new(2) { Knight.new(color) },
      queen: Queen.new(color),
      king: King.new(color)
    ]
  end
end
