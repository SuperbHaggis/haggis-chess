Dir['/home/turner/odin-project/haggis-chess/lib/*.rb'].each { |file| require file }
require 'pry'

game = Game.new

white_pawn = game.board.spaces['2'][3]
game.board.spaces['7'][4].piece = nil
white_queen = game.board.spaces['1'][3].piece
white_queen.move(game.board.spaces['6'][2])
white_queen.previous.piece = nil
white_queen.space.piece = white_queen

game.board.display

gameover = false
game.play_round while gameover == false
binding.pry
