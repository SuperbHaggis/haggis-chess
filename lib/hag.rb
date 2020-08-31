require 'yaml'

class Hag
  def run(game)
    input = gets.chomp.downcase
    case input
    when 'help'
      help
    when 'save'
      save(game)
    when 'load'
      load(game)
    when 'display'
      game.board.display
    when /[A-H][1-8]/i
      input
    else
      puts '>> Please enter a valid command (enter \'help\' for more options).'
    end
  end
end

private

def help
  file = File.open('../docs/help.txt')
  puts file.readlines.map(&:chomp)
  nil
end

def save(game)
  File.open('../save/gamesave.yml', 'w') { |file| file.write(game.board.spaces.to_yaml) }
  puts '>> Game saved!'
  nil
end

def load(game)
  savedata = YAML.load(File.read('../save/gamesave.yml'))
  game.board.spaces = savedata
  nil
end
