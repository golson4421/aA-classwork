require_relative "piece"
require_relative "pawn"
require_relative "king"
require_relative "queen"
require_relative "bishop"
require_relative "knight"
require_relative "rook"
require "colorize"

#   0 1 2 3 4 5 6 7
# 0 R K B K Q B K R #white
# 1 P P P P _ P P P
# 2 _ _ _ _ P _ _ _
# 3 _ _ _ _ _ _ _ _
# 4 _ _ _ _ _ _ _ _
# 5 _ _ _ _ _ _ _ _
# 6 P P P P P P P P #black
# 7 R K B K Q B K R

class Board

    attr_reader :piece, :rows

    def initialize
        @rows = Array.new(8) {Array.new(8)}
        self.place_pawns
        self.place_kings
        self.place_queens
        self.place_bishops
        self.place_knights
        self.place_rooks
        self.place_nulls
    end

    def place_pawns
        (0..7).each do |i|
            @rows[1][i] = Pawn.new(:white, self, [1, i])
            @rows[6][i] = Pawn.new(:black, self, [6, i])
        end
    end

    def place_kings
        @rows[0][3] = King.new(:white, self, [0,3])
        @rows[7][3] = King.new(:black, self, [7,3])
    end

    def place_queens
        @rows[0][4] = Queen.new(:white, self, [0,4])
        @rows[7][4] = Queen.new(:black, self, [7,4])
    end

    def place_bishops
        @rows[0][2] = Bishop.new(:white, self, [0,2])
        @rows[0][5] = Bishop.new(:white, self, [0,5])
        
        @rows[7][2] = Bishop.new(:black, self, [7,2])
        @rows[7][5] = Bishop.new(:black, self, [7,5])
    end

    def place_knights
        @rows[0][1] = Knight.new(:white, self, [0,1])
        @rows[0][6] = Knight.new(:white, self, [0,6])
        
        @rows[7][1] = Knight.new(:black, self, [7,1])
        @rows[7][6] = Knight.new(:black, self, [7,6])
    end

    def place_rooks
        @rows[0][0] = Rook.new(:white, self, [0,0])
        @rows[0][7] = Rook.new(:white, self, [0,7])
        
        @rows[7][0] = Rook.new(:black, self, [7,0])
        @rows[7][7] = Rook.new(:black, self, [7,7])
    end

    def place_nulls
        (2..5).each do |i|
            (0..7).each do |j|
                @rows[i][j] = NullPiece.instance
            end
        end
    end

    def [](pos)
        r, c = pos[0], pos[1]
        @rows[r][c]
    end

    def []=(pos,value)
        r, c = pos[0], pos[1]
        @rows[r][c] = value
    end

    def valid_pos?(pos)
        r,c = pos
        return false unless r.between?(0,7) && c.between?(0,7)
        true
    end

    def move_piece(start_pos, end_pos)
        selected_piece = self[start_pos]
        if self[start_pos].color == :_
            raise StandardError.new "No piece at selected start position."
        end
        unless self.valid_pos?(end_pos) && selected_piece.moves.include?(end_pos)
            raise StandardError.new "Not a valid end position for your selected #{selected_piece.class.name}."
        end
        puts "You took your opponent's #{self[end_pos].class.name}" unless self[end_pos].color == :_
        self[end_pos] = selected_piece
        selected_piece.pos = end_pos
        self[start_pos] = NullPiece.instance
        return
    end

    def render
        self.rows.each_with_index do |row,i|
            mapped_row = row.map.with_index do |piece,j|
                if (i+j).even?
                    piece.symbol.colorize(piece.color).on_light_black
                else
                    piece.symbol.colorize(piece.color).on_light_red
                end
            end.join("".on_light_black)
            puts mapped_row
        end
        return
    end


end