class Space
  attr_accessor :coord, :color, :image, :default_image, :open

  def initialize(coord1, coord2, color)
    @coord = [coord1, coord2]
    @color = color
    @default_image = @color == 'black' ? '■' : '□'
    @image = @default_image
    @open = true
  end

  def update(piece)
    @image = piece.image
  end
end
