# For both of these problems, assume there is a Node class. The node class will take in a value as part of its initialization. You will monkeypatching the following methods:
# 1. Write a method `bfs` that does a breadth-first search starting at a root node. It takes in a target, and a proc as an argument.
# 2. Write a method `dfs` that does a depth-first search starting at a root node. It takes in a target, and a proc as an argument.
# Example usage:
# n1 = Node.new(1) # making a node with a value of 1
# n1.bfs(1) #=> n1
# n1.dfs { |node| node.value == 1 } #=> n1 (found a node with value == 1)


# givens:
# -node class already made
# -one node's value already given
# -target given, proc given

# assumptions:
# -child nodes defined as part of initialize method
# -parent<=>child relationship can be read at each node individually
# -target's value is defined, or that node's value can be read by standard class method


# questions:
# - what is the proc meant to do, maybe it's how you determine the node<=>value relationship?
# - is parent<=>child bidirectional, or only one-way (parent=>child, can't read parent from child)?


# implementation:
# - bfs search requires searching all of one node's children before moving on to their children
# - going to use a Queue (FIFO) data structure to queue up children nodes and read the first-added node before its children
# - initialize queue as a 1-D array containing only the root to start
# - simulate queue structure by only reading from the end (pop), queueing to the front (unshift)
# - until the queue is empty, we'll pop the last element, check whethere its value is the target; if it's not, then we queue up the children via unshift, then go back to the top of the loop and pop the next in line.

pseudo-code:
def bfs(target)
    queue = [root] # initialize queue
    until queue.empty?
        node = queue.pop # take the first-in-line node
        return node if prc.call(node) # not sure whether proc will evaluate to bool or to a value
        node.children.each { |child| queue.unshift(child) }
    end
    nil
end


target == 6

          1
    [1,2]  [3,4]
[5,6]

Proc.new { |node,target| node == target }
Proc.new { |node| node == target }


def dfs(target, &prc)
  return self if prc.call(self,target)
  self.children.each do |child|
    memo = child.dfs(target,&prc)
    return memo unless memo.nil?
  end
  nil
end




class Node
  # -- Assume nodes have a value, and a attr_reader on value
  # -- Also, assume there are working parent/child-related methods for Node
  def bfs(&prc)
    raise "Must give a proc or target" if prc.nil?
    queue = [self]
    until queue.empty?
      visited = queue.shift
      return visited if prc.call(visited)
      queue += visited.children
    end
    nil
  end
  def dfs(&prc)
    raise "Must give a proc or target" if prc.nil?
    return self if prc.call(self)
    self.children.each do |node|
      result = node.dfs(target, &prc)
      return result if result
    end
    nil
  end
end