require_relative "piece"
require_relative "modules"

class Queen < Piece
    include Slideable

    DIRS_LIST = ALL_DIRS.keys

    def symbol
        @symbol = "Q♛"
    end

    def moves
        super(@pos, @board, DIRS_LIST)
    end
    
end