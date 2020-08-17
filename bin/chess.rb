Dir['/home/turner/odin-project/haggis-chess/lib/*.rb'].each { |file| require file }
require 'pry'

game = Game.new
# space = game.board.spaces['5'][3]
# queen = game.board.spaces['8'][3].piece
# queen.space.find_adjacent_queen(game.board)
# binding.pry
gameover = false
game.play_round while gameover == false
binding.pry
