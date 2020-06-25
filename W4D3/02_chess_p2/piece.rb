require "singleton"

class Piece

    attr_accessor :symbol, :color, :pos, :board

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def inspect
        "<#{self.symbol}- #{self.color} #{self.class.name}: pos = #{self.pos}>"
    end

    def to_s
    end

    def empty?
        @color == :_
    end

    def valid_moves
    end

    def pos=(val)
        @pos = val
    end

    # def symbol
    # end

    private

    def move_into_check?(end_pos)
    end
    
end

class NullPiece
    include Singleton
    attr_accessor :color, :symbol

    def initialize
        @color = :_
        @symbol = "  "
    end

    def inspect
        "<#{self.class.name}>"
    end

    def moves
        []
    end

end