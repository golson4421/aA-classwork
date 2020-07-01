require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos, :children, :current_mark
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator) #evaluator is the mark
    return self.board.won? && self.board.winner != evaluator if self.board.over?

    if self.next_mover_mark == evaluator
      self.children.all? { |node| node.losing_node?(evaluator) }
    else
      self.children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return self.board.winner == evaluator if self.board.over?

    if self.next_mover_mark == evaluator
      self.children.any? { |node| node.winning_node?(evaluator) }
    else
      self.children.all? { |node| node.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @children = []
    self.board.rows.each_with_index do |row, i|
      row.each_with_index do |ele, j|
        pos = [i, j]
        next unless @board.empty?(pos)
        new_board = self.board.dup
        new_board[pos] = self.next_mover_mark
        @next_mover_mark = ((@next_mover_mark == :x) ? :o : :x)
        @children << TicTacToeNode.new(new_board, @next_mover_mark, pos)
      end
    end
    @children
  end
end
