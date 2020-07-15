class Board
  attr_accessor :spaces

  def initialize
    @spaces = Hash.new
    spaces = create_spaces
    ('1'..'8').to_a.reverse.each do |num|
      @spaces[num] = spaces.shift
    end
  end

  def create_blanks
    blanks = Array.new(8) { Array.new(8) { [] } }
    blanks.map! do |row|
      if blanks.index(row).even?
        row.each { |space| row.index(space).even? ? space << 'white' : space << 'black' }
      else
        row.each { |space| row.index(space).even? ? space << 'black' : space << 'white' }
      end
    end
    blanks
  end

  def create_spaces
    spaces = create_blanks.map { |row| row.map { |space| Space.new(space[0]) } }
    spaces.each do |row|
      letters = ('A'..'H').to_a
      row.each { |space| space.letter = letters.shift }
    end
    spaces
  end

  def refresh
    @spaces.each { |_key, index| index.each(&:update) }
  end

  def display
    refresh
    @spaces.each { |key, index| puts "#{key.to_s} #{index.map(&:image).join(' ')}" }
    puts '  ' + ('A'..'H').to_a.join(' ')
  end

  def find_space(letter, num)
    @spaces[num].find { |index| index.letter == letter }
  end
end
