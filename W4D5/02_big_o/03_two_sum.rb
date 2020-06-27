## Phase 1 — Brute Force

def bad_two_sum?(array, target)
    pairs = array.combination(2).to_a
    pairs.any? { |pair| pair.sum == target }
end

puts "-----"
puts "brute_force: finding combinations for bad_two_sum method is expensive O(n^2),"
puts "then iterating through them to find the target sum is O(n/2 * (n-1)/2), which is dominated by n^2"
arr = [0, 1, 5, 7]
p bad_two_sum?(arr, 6)
p bad_two_sum?(arr, 10)



## Phase 2 — Sorting

def okay_two_sum?(array, target, sorted=false)
    array.sort! unless sorted #ruby's built-in sort is quicksort, which has O(n log n) complexity
    mid = array.length / 2
    left = array.take(mid)
    right = array.drop(mid+1)
    return false if left.empty? || right.empty?
    case array[mid] + left.last <=> target
    when 0
        return true
    when -1
        okay_two_sum?(left, target, true)
    when 1
        case array[mid] + right.first <=> target
        when 0
            return true
        when -1
            return false
        when 1
            okay_two_sum?(right, target, true)
        end
    end
end

puts "-----"
puts "sorting: sorting the array using built-in takes O(n log n). Binary searching through the sorted"
puts "array adds O(log n) complexity, which doesn't factor into the overall method complexity"
p okay_two_sum?(arr, 6)
p okay_two_sum?(arr, 10)



def hash_two_sum?(arr, target)
    hash = Hash.new(0)
    arr.each_with_index do |ele,i|
        return true if hash.has_key?(target-ele)
        hash[ele] = i
    end
    false
end

puts "-----"
puts "start by iterating through the array, and check if target-current_ele has already been added to the hash,"
puts "then we add the current_ele to the hash and go to the next ele"
puts "using a hash makes allows our lookups within the loop through arr cost nothing, so the complexity is O(n)"
p hash_two_sum?(arr, 6)
p hash_two_sum?(arr, 10)