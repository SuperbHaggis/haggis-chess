class Player
  attr_accessor :color, :pieces, :captured

  def initialize(color)
    @color = color
    @pieces = {
      bishops: [],
      knights: [],
      pawns: [],
      rooks: []
    }
    create_pieces(color)
  end

  private

  def create_pieces(color)
    8.times { @pieces[:pawns] << Pawn.new(color) }
    2.times do
      @pieces[:rooks] << Rook.new(color)
      @pieces[:bishops] << Bishop.new(color)
      @pieces[:knights] << Knight.new(color)
    end
    @pieces[:queen] = Queen.new(color)
    @pieces[:king] = King.new(color)
  end

  def capture(foe)
    @captured << foe
  end

  def lose(friend)
    @pieces.each do |_k, v|
      if v.class == Array
        v.delete(friend) if v.include?(friend)
      end
    end
  end
end
