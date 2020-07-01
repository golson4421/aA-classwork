require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    winner = children.find { |child| child.winning_node?(mark) }
    return winner.prev_move_pos if winner
    non_loser = children.find { |child| !child.losing_node?(mark) }
    return non_loser.prev_move_pos if non_loser
    raise ArgumentError.new("cannot pick a winner or draw")
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Tim")
  # cp1 = SuperComputerPlayer.new
  cp2 = SuperComputerPlayer.new

  TicTacToe.new(hp, cp2).run
end
