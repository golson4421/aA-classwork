class PolyTreeNode
    attr_reader :value, :parent
    attr_accessor :children, :value

    def initialize(value)
        @value = value ; @parent = nil ; @children = []
    end

    def parent=(parent_node)
        prev_parent = @parent
        @parent = parent_node
        return if @parent.nil?
        prev_parent.children.delete(self) unless prev_parent.nil?
        parent_node.children << self unless parent_node.children.include?(self)
    end

    def add_child(child_node)
        child_node.parent = self
        @children << child_node unless @children.include?(child_node)
    end

    def remove_child(child_node)
        unless @children.include?(child_node)
            raise ArgumentError.new("Invalid child request")
        else
            child_node.parent = nil
        end

    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            result = queue.pop
            return result if result.value == target_value
            result.children.each { |child| queue.unshift(child) }
        end
        nil
    end

    def inspect
        "<node #{self.value}: parent=#{self.parent.value} ; children=#{self.children}"
    end

    def print
        puts "Node is #{self.value};"
        puts "#{self.value}'s Parent is: #{self.parent.nil? ? "nothing" : self.parent.value};"
        puts "Children are:"
        self.children.each_with_index do |child, i|
            puts "index #{i} => #{child.value}"
        end
        puts "________________________"
        nil
    end


end