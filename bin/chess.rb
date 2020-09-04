Dir['/home/turner/odin-project/haggis-chess/lib/*.rb'].each { |file| require file }
require 'pry'

file = File.open('../docs/title.txt')
puts file.readlines.map(&:chomp)
gets.chomp
puts '>> Welcome to Haggis Chess!'
puts ">> Type 'help' at any time for a list of useful commands."
puts ''
game = Game.new
game.play
