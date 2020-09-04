require 'yaml'

class Hag
  def run(game, player, phase, piece = nil)
    input = gets.chomp.downcase
    case input
    when 'help'
      help
    when 'save'
      save(game, player, piece)
      end_text(player, phase)
    when 'load'
      load(game)
    when 'display'
      game.board.display
      end_text(player, phase)
    when /[A-H][1-8]/i
      input
    else
      puts '>> Please enter a valid command (enter \'help\' for more options).'
    end
  end

  private

  def help
    file = File.open('../docs/help.txt')
    puts file.readlines.map(&:chomp)
    nil
  end

  def save(game, player, piece)
    data = [game.board.spaces, player]
    data << piece unless piece.nil?
    File.open('../save/gamesave.yml', 'w') { |file| file.write(data.to_yaml) }
    puts '>> Game saved!'
    nil
  end

  def load(game)
    savedata = YAML.load(File.read('../save/gamesave.yml'))
    game.board.spaces = savedata[0]
    game.board.display
    puts '>> Game loaded!'
    savedata[1..-1]
  end

  def end_text(player, phase)
    if phase == 'piece'
      puts ">> #{player.capitalize} player, choose a piece by coordinate: "
    else
      puts phase
    end
  end
end
