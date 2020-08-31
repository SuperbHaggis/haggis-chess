class Hag
  def run(board)
    input = gets.chomp.downcase
    case input
    when 'help'
      file = File.open('../docs/help.txt')
      puts file.readlines.map(&:chomp)
      nil
    when 'save'
      puts '>> Game saved!'
    when 'display'
      board.display
    when /[A-H][1-8]/i
      input
    else
      puts '>> Please enter a valid command (enter \'help\' for more options).'
    end
  end
end
