require_relative "piece"
require_relative "modules"

class King < Piece
    include Stepable

    DIFFS_LIST = KING_DIFFS.keys

    def symbol
        @symbol = "K♚"
    end

    def moves
        super(@pos, @board, DIFFS_LIST)
    end
    
end