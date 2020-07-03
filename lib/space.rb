class Space
  attr_accessor :coord, :children, :color

  def initialize(coord)
    @coord = coord
    @children = []
    @color = nil
  end
end
