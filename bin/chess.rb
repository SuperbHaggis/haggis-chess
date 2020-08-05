Dir['/home/turner/odin-project/haggis-chess/lib/*.rb'].each { |file| require file }
require 'pry'

game = Game.new
# game.board.build_tree(piece1, space2, space1)
binding.pry
gameover = false
game.play_round while gameover == false
binding.pry
