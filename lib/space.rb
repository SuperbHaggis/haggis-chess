class Space
  attr_accessor :coord, :color, :image, :default_image, :piece

  def initialize(coord1, coord2, color)
    @coord = [coord1, coord2]
    @color = color
    @default_image = @color == 'white' ? '■' : '□'
    @image = @default_image
    @piece = nil
  end

  def update
    @image = @piece.nil? ? @default_image : @piece.image
  end
end
