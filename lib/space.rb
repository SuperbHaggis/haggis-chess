class Space
  attr_accessor :coord, :children, :color, :image

  def initialize(coord)
    @coord = coord
    @children = []
    @color = nil
    @image = @color == 'black' ? '■' : '□'
  end
end
