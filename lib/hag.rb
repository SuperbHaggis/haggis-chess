class Hag
  def run(board)
    input = gets.chomp.downcase
    case input
    when 'help'
      puts '>> Need some help?'
    when 'save'
      puts '>> Game saved!'
    when 'display'
      board.display
    when /[A-H][1-8]/i
      input
    else
      puts '>> Please enter a valid command.'
    end
  end
end
