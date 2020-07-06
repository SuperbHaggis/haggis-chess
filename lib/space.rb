class Space
  attr_accessor :coord, :children, :color, :image

  def initialize(coord1, coord2, color)
    @coord = [coord1, coord2]
    @children = []
    @color = color
    @image = @color == 'black' ? '■' : '□'
  end
end
