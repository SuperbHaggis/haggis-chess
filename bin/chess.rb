Dir['/home/turner/odin-project/haggis-chess/lib/*.rb'].each { |file| require file }
require 'pry'

game = Game.new
game.setup
game.board.display
binding.pry
