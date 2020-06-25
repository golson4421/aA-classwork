require "byebug"
module Slideable
    
    def grow_unblocked_moves_in_dir(start_pos, board, direction) #start_pos = [0,0], dxdy = [0,1] creates list of start_pos in a single direction
        color = self.color
        oppo_color = self.color == :black ? :white : :black
        dx, dy = ALL_DIRS[direction]
        move_tree = [start_pos.dup]
        while board.valid_pos?(move_tree.last)
            last_move = move_tree.last
            next_move = [last_move[0] + dx, last_move[1] + dy]
            break if board[next_move].color == self.color #queen.grow_unblocked_moves_in_dir([0,4],b,:down)
            move_tree << next_move
            break if board[next_move].color == oppo_color
        end
        move_tree[1..-1].select { |move| board.valid_pos?(move) }
    end
    
    def moves(start_pos, board, dirs_list) #[up, down, left, right]
        # Queen class dirs_list = All_DIRS.keys ;  Rook class dirs_list = HORIZONTAL_DIRS.keys
        all_moves = []
        dirs_list.each do |direction|
            all_moves += grow_unblocked_moves_in_dir(start_pos, board, direction)
        end
        all_moves.uniq
    end

    HORIZONTAL_DIRS = {
        up: [-1,0],
        down: [1,0],
        left: [0,-1],
        right: [0,1]
    }
    
    DIAGONAL_DIRS = {
        down_right: [1,1],
        up_left: [-1,-1],
        down_left: [1,-1],
        up_right: [-1,1]
    }

    ALL_DIRS = HORIZONTAL_DIRS.merge(DIAGONAL_DIRS)

end


module Stepable

    def moves(start_pos, board, diffs_list)
        move_tree = []
        diffs_list.each do |diff|
            dx, dy = ALL_DIFFS[diff]
            next_move = [start_pos[0] + dx, start_pos[1] + dy]
            next if board[next_move].color == self.color || !board.valid_pos?(next_move)
            move_tree << next_move
        end
        move_tree
    end

    KNIGHT_DIFFS = {
        knight_up_left: [-2,-1],
        knight_up_right: [-2,1],
        knight_left_down:[1,-2],
        knight_right_down: [1,2],
        knight_right_up: [-1,2],
        knight_left_up: [-1,-2],
        knight_down_left: [2,-1],
        knight_down_right: [2,1]
    }

    KING_DIFFS = {
        king_up: [-1,0],
        king_down: [1,0],
        king_left: [0,-1],
        king_right: [0,1],
        king_down_right: [1,1],
        king_up_left: [-1,-1],
        king_down_left: [1,-1],
        king_up_right: [-1,1]
    }
    
    ALL_DIFFS = KNIGHT_DIFFS.merge(KING_DIFFS)

end