class Space
  attr_accessor :coord, :color, :image, :default_image, :piece, :index

  def initialize(color)
    @color = color
    @default_image = @color == 'white' ? '■' : '□'
    @image = @default_image
    @piece = nil
  end

  def update
    @image = @piece.nil? ? @default_image : @piece.image
  end
end
