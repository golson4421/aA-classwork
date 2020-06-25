require_relative "piece"
require_relative "modules"

class Knight < Piece
    include Stepable

    DIFFS_LIST = KNIGHT_DIFFS.keys

    def symbol
        @symbol = "N♞"
    end

    def moves
        super(@pos, @board, DIFFS_LIST)
    end
    
end