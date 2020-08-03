Dir['/home/turner/odin-project/haggis-chess/lib/*.rb'].each { |file| require file }
require 'pry'

game = Game.new
gameover = false
game.play_round while gameover == false
binding.pry
