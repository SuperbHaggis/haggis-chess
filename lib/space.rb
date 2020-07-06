class Space
  attr_accessor :coord, :children, :color, :image

  def initialize(coord, color)
    @coord = coord
    @children = []
    @color = color
    @image = @color == 'black' ? '■' : '□'
  end
end
