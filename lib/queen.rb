require_relative './piece.rb'

class Queen < Piece
  def initialize(color)
    @color = color
    @image = color == 'white' ? '♛' : '♕'
    @moveset = [
      # diagonal
      [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
      [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7],
      [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
      [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7],
      # horizontal
      [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
      [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
      # vertical
      [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
      [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
    ]
    @path = []
  end

  def legal_move?(space, board)
    move = @space.coord.zip(space.coord).map { |x, y| y - x }
    moveset = if @moveset[0..27].include?(move)
                @moveset[0..27]
              elsif @moveset[28..41].include?(move)
                @moveset[28..41]
              else
                @moveset[42..-1]
              end
    if space.piece.nil?
      true if moveset.include?(move) && board.clear_path?(self, space)
    elsif space.piece.color != @color
      true if moveset.include?(move) && board.clear_path?(self, space)
    else
      false
    end
  end

  def moveable?(board)
    adjacent = @space.find_adjacent_queen(board)
    if adjacent.all?(&:occupied?)
      return adjacent.any? { |space| space.piece.color != @color }
    end

    adjacent.any? { |space| !space.occupied? }
  end
end
