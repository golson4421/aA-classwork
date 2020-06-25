class Array

    def my_uniq
        uniq_arr = []
        self.each do |ele|
            uniq_arr << ele if !uniq_arr.include?(ele)
        end
        uniq_arr
    end

    def two_sum
      pairs = []
      (0...self.length).each do |i|
        (i...self.length).each do |j|
          next if i == j
          pairs << [i, j] if self[i] + self[j] == 0
        end
      end
      pairs
    end

    def my_transpose
        self.each do |row|
            raise ArgumentError unless self.length == row.length
        end
        transposed = Array.new(self.length) { Array.new }
        self.each_with_index do |row,i|
            transposed[i] = self.map { |column| column[i]  }
        end
        transposed
    end
end

def stock_picker(arr)
  hash = {}
  arr.each_with_index do |ele, i|
    (i + 1...arr.length).each do |j|
      hash[arr[j] - ele] = [i, j]
    end
  end
  max_key = hash.keys.max_by { |k| [k, hash[k][0]] }
  return hash[max_key]
end




class TowersOfHanoi
    attr_accessor :towers, :remaining_tries

    def initialize
        @towers = [[1,2,3],[],[]]
        @remaining_tries = 10
        self.won?
    end

    def move(starting_peg, ending_peg)
        raise ArgumentError unless starting_peg.between?(1,3) && ending_peg.between?(1,3)
        raise ArgumentError if towers[starting_peg-1].empty?
        raise ArgumentError if towers[starting_peg-1].first > (towers[ending_peg-1].first ||= 4)
        towers[ending_peg-1].unshift(towers[starting_peg-1].shift)
        @remaining_tries -= 1
    end

    def won?
      return false unless towers[1] == [1,2,3] || towers[2] == [1,2,3]
      return false if @remaining_tries == 0
      return true 
    end

end
