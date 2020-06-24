require_relative "./piece.rb"

class Board

    attr_reader :piece, :rows

    def initialize
        @rows = Array.new(8) {Array.new(8)}

        (0..1).each do |i|
            (0...8).each do |j|
                @rows[i][j] = Piece.new(:white, self, [i, j])
                @rows[i+6][j] = Piece.new(:black, self, [i+6, j])
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

    def move_piece(start_pos, end_pos)
        if self[start_pos].nil?
            raise StandardError.new "No piece at selected start position."
        end
        piece = self[start_pos]
        unless piece.valid_moves.include?(end_pos)
            raise StandardError.new "Not a valid end position for your selected #{piece}."
        end
        self[end_pos] = piece.symbol ; self[start_pos] = nil
        return
    end

    def render
        self.rows.each do |row|
            puts row.map(&:symbol).join("|")
            puts "----------------------------"
        end
    end


end