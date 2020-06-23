require "byebug"
require_relative "./polytreenode.rb"

class KnightPathFinder
    attr_reader :considered_positions, :root_node, :target_position, :move_tree, :all_positions
    
    def self.valid_moves(starting_position)
        valid_moves = []
        moves = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
        moves.each do |move|
            possible_move = KnightPathFinder.position_addition(starting_position, move)
            valid_moves << position_addition(starting_position, move)
        end
        valid_moves
    end

    def self.position_addition(starting_position, move)
        [starting_position[0] + move[0], starting_position[1] + move[1]]
    end

    def initialize(initial_pos)
       all_positions = []
        (0...8).each do |i|
            (0...8).each do |j|
                all_positions << [i,j]
            end
        end
        @all_positions = all_positions
        @root_node = PolyTreeNode.new(initial_pos)
        @considered_positions = [initial_pos]
        self.build_move_tree(initial_pos)
    end

    def build_move_tree(initial_pos)
        queue = [@root_node]
        until queue.empty?
            result = queue.pop
            result_position = result.value
            child_positions = self.new_move_positions(result_position)
            children = child_positions.map { |child_position| PolyTreeNode.new(child_position) }
            children.each do |child_node|
                queue.unshift(child_node)
                result.add_child(child_node)
            end
        end
    end

    def new_move_positions(position)
        valid_moves = KnightPathFinder.valid_moves(position)
        valid_moves.reject!{ |move| @considered_positions.include?(move) || !(@all_positions.include?(move)) }
        @considered_positions += valid_moves
        valid_moves
    end

    def find_path(end_pos)
        final_node = @root_node.bfs(end_pos)
        self.trace_path_back(final_node)
    end

    def trace_path_back(node)
        path = [node]
        until path.first.value == @root_node.value
            path.unshift(path.first.parent)
        end
        path.map(&:value)
    end











end
