class Space
  attr_accessor :coord, :color, :image, :default_image, :piece, :letter,
                :adjacent

  def initialize(color, coord)
    @color = color
    @coord = coord
    @default_image = @color == 'white' ? '■' : '□'
    @image = @default_image
    @piece = nil
    @adjacent = []
  end

  def update
    @image = @piece.nil? ? @default_image : @piece.image
  end

  def occupied?
    !@piece.nil?
  end
end
