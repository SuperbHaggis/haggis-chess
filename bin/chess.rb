Dir['/home/turner/odin-project/haggis-chess/lib/*.rb'].each { |file| require file }
require 'pry'

file = File.open('../docs/title.txt')
puts file.readlines.map(&:chomp)
gets.chomp
game = Game.new
game.play
