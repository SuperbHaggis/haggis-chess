class Board
  attr_accessor :spaces

  def initialize
    coords = Array.new(8) { Array.new(8) { [] } }
    coords.map! { |row| row.map! { |space| [coords.index(row), row.index(space)] } }
    coords.map! do |row|
      if coords.index(row).even?
        row.each { |space| row.index(space).even? ? space << 'white' : space << 'black' }
      else
        row.each { |space| row.index(space).even? ? space << 'black' : space << 'white' }
      end
    end
    @spaces = coords.map { |row| row.map { |space| Space.new(space[0], space[1], space[2]) } }
  end
end

#   0 1 2 3 4 5 6 7
# 0 ■ □ ■ □ ■ □ ■ □
# 1 □ ■ □ ■ □ ■ □ ■
# 2 ■ □ ■ □ ■ □ ■ □
# 3 □ ■ □ ■ □ ■ □ ■
# 4 ■ □ ■ □ ■ □ ■ □
# 5 □ ■ □ ■ □ ■ □ ■
# 6 ■ □ ■ □ ■ □ ■ □
# 7 □ ■ □ ■ □ ■ □ ■
