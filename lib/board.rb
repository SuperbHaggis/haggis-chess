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

  def display
    puts '  ' + (0..7).to_a.map(&:to_s).join(' ')
    puts(@spaces.map { |row| spaces.index(row).to_s + ' ' + row.map(&:image).join(' ') })
  end
end
