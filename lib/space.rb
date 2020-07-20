class Space
  attr_accessor :coord, :color, :image, :default_image, :piece, :letter

  def initialize(color, coord)
    @color = color
    @coord = coord
    @default_image = @color == 'white' ? '■' : '□'
    @image = @default_image
    @piece = nil
  end

  def update
    @image = @piece.nil? ? @default_image : @piece.image
  end
end
