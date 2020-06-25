require_relative "piece"
require_relative "modules"

class Bishop < Piece
    include Slideable

    def symbol
        @symbol = "B♝"
    end

    def moves
        super(@pos, @board, self.moves_dir)
    end

    def moves_dir
        DIAGONAL_DIRS.keys
    end
    
end