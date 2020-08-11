Dir['/home/turner/odin-project/haggis-chess/lib/*.rb'].each { |file| require file }
require 'pry'

game = Game.new
piece1 = game.board.spaces['8'][0].piece
space2 = game.board.spaces['6'][0]
space1 = piece1.space
# binding.pry
# game.board.build_tree(piece1, space2)
game.board.build_path(piece1, game.board.build_tree(piece1, space2))
binding.pry
gameover = false
game.play_round while gameover == false
binding.pry
