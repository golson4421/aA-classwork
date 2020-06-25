require_relative "piece"
require_relative "modules"

class Rook < Piece
    include Slideable

    DIRS_LIST = HORIZONTAL_DIRS.keys

    def symbol
        @symbol = "R♜"
    end

    def moves
        super(@pos, @board, DIRS_LIST)
    end
    
end