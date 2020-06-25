require_relative "piece"

class Pawn < Piece

    def symbol
        @symbol = "P♟"
    end

    def moves
        all_moves = []
        start_pos = self.pos
        self.forward_steps.each do |step|
            new_pos = [(start_pos[0] + step * self.forward_dir), start_pos[1]]
            all_moves << new_pos
        end
        all_moves + self.side_attacks
    end

    def at_start_row?
        (@color == :black && @pos.first == 6) ||
            (@color == :white && @pos.first == 1)
    end

    def forward_dir
        return -1 if @color == :black
        return 1 if @color == :white
    end

    def forward_steps
        at_start_row? ? [1,2] : [1]
    end

    def side_attacks
        all_attacks = []
        [-1, 1].each do |attack|
            new_pos = [@pos[0] + self.forward_dir , @pos[1] + attack]
            all_attacks << new_pos unless @board[new_pos].color == :_
        end
        all_attacks
    end
end