class Board
  attr_accessor :spaces

  def initialize
    @spaces = Hash.new
    spaces = create_spaces
    ('1'..'8').to_a.reverse.each do |num|
      @spaces[num] = spaces.shift
    end
  end

  def display
    refresh
    @spaces.each { |k, v| puts "#{k} #{v.map(&:image).join(' ')}" }
    puts '  ' + ('A'..'H').to_a.join(' ')
  end

  def find_space(letter, k)
    @spaces[k].find { |space| space.letter == letter }
  end

  def find_coord(coord)
    space_row = @spaces.find { |_k, v| v.find { |s| s.coord == coord } }
    space_row.shift
    space_row[0].find { |space| space.coord == coord }
  end

  private

  def refresh
    @spaces.each { |_k, row| row.each(&:update) }
  end

  def create_grid
    grid = Array.new(8) { Array.new(8) { [] } }
    grid.map! do |row|
      if grid.index(row).even?
        row.each { |space| row.index(space).even? ? space << 'white' : space << 'black' }
      else
        row.each { |space| row.index(space).even? ? space << 'black' : space << 'white' }
      end
      row.map! do |space|
        space << [grid.index(row), row.index(space)]
      end
    end
    grid.reverse
  end

  def create_spaces
    spaces = create_grid.map { |row| row.map { |space| Space.new(space[0], space[1]) } }
    spaces.each do |row|
      letters = ('A'..'H').to_a
      row.each { |space| space.letter = letters.shift }
    end
    spaces
  end
end
