require_relative "./polytreenode.rb"

class KnightPathFinder

    def self.all_positions
        all_positions = []
        (0...8).each do |i|
            (0...8).each do |j|
                all_positions << [i,j]
            end
        end
        all_positions
    end

    def self.valid_moves(pos)
        x, y = pos
        valid_moves = KnightPathFinder.all_positions.select do |position|
            #vertical 2, horizontal 1
            (position[0] == y + 2 && position[1] == x + 1) ||
            #vertical -2, horizontal 1
            (position[0] == y - 2 && position[1] == x + 1) ||
            #vertical 2, horizontal -1
            (position[0] == y + 2 && position[1] == x - 1) ||
            #vertical -2, horizontal -1
            (position[0] == y - 2 && position[1] == x - 1) ||
            #horizontal 2, vertical 1
            (position[0] == y + 1 && position[1] == x + 2) ||
            #horizontal -2, vertical 1
            (position[0] == y + 1 && position[1] == x - 2) ||
            #horizontal 2, vertical -1
            (position[0] == y - 1 && position[1] == x + 2) ||
            #horizontal -2, vertical -1
            (position[0] == y - 1 && position[1] == x - 2)
        end
    end

    def initialize(initial_pos, target_position)

        @root_node = PolyTreeNode.new(initial_pos)
        self.build_move_tree(initial_pos)
        @considered_positions = [initial_pos]
        @target_position = target_position
    end

    def build_move_tree(initial_pos)
        queue = [@root_node]
        until queue.empty?
            result = queue.pop
            return result if result.value == @target_position
            children = new_move_positions(result.value)
            children.each { |child| queue.unshift(child) }
        end
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)
        moves.reject!{|move| @considered_positions.include?(move)}
        moves.map { |position| PolyTreeNode.new(position) }
    end









end
