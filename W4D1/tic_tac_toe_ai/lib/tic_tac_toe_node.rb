require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos, :children, :current_mark
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos

    if @next_mover_mark == :x
      @current_mark = :o
    else
      @current_mark = :x
    end

  end

  def losing_node?(evaluator) #evaluator is the mark
    return true if self.board.over? && self.board.winner != evaluator
    return false if self.board.over? && (self.board.winner == evaluator || self.board.winner.nil?)
    if self.current_mark == evaluator
      self.children.any? do |child|
        child.losing_node?(evaluator)
      end
    else
      self.children.none? do |child|
        child.losing_node?(self.next_mover_mark)
      end
    end
  end

  def winning_node?(evaluator)
    return true if self.board.over? && self.board.winner == evaluator
    return false if self.board.over? && (self.board.winner != evaluator || self.board.winner.nil?)
    if self.current_mark == evaluator
      self.children.any? do |child|
        child.winning_node?(evaluator)
      end
    else
      self.children.none? do |child|
        child.winning_node?(self.next_mover_mark)
      end
    end
    # !self.losing_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @children = []
    self.board.rows.each_with_index do |row, i|
      row.each_with_index do |ele, j|
        pos = [i, j]
        next if !@board.empty?(pos)
        new_board = self.board.dup
        new_board[pos] = self.next_mover_mark
        next_next_turn = ((@next_mover_mark == :x) ? :o : :x)
        @children << TicTacToeNode.new(new_board, next_next_turn, pos)
      end
    end
    @next_mover_mark = ((@next_mover_mark == :x) ? :o : :x)
    @children
  end
end
