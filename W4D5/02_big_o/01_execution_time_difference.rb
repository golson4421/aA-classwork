## my_min

# phase 1 - compare all elements to the rest of the array

def my_min_1(array)
    array.each_with_index do |ele,i|
        rest = array[0...i] + array[i+1..-1]
        return ele if rest.all? { |other_ele| other_ele >= ele }
    end
end
list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

puts "-----"
puts "complexity of my_min_1 is O(n^2)— two nested loops of max length n required to find min"
puts ">min of list is: #{my_min_1(list)}"

# phase 2 - keep track of largest number as you iterate through

def my_min_2(array)
    array.inject(0) do |acc,ele|
        acc > ele ? ele : acc
    end
end

puts "-----"
puts "complexity of my_min_2 is is O(n)— one loop of definite length n require to find min"
puts ">min of list is: #{my_min_2(list)}"





## Largest Contiguous Sub-sum

list1 = [5, 3, -7]
list2 = [2, 3, -6, 7, -6, 7]
list3 = [-5, -1, -3]

# phase 1 — create sub-arrays first, then calculate sum and return the max sum

def largest_contiguous_subsum_1(array)
    sub_arrs = []
    array.each_index do |i|
        (i...array.length).each do |j|
            sub_arrs << array[i..j]
        end
    end

    sub_arrs.map(&:sum).max
end

puts "-----"
puts "complexity of largest_contiguous_subsum_1 is is O(n^3) {for creating the subsets and the slice} + O(2n) {for then for calculating the sum}, so O(n^2) dominates"
p largest_contiguous_subsum_1(list1)
p largest_contiguous_subsum_1(list2)
p largest_contiguous_subsum_1(list3)



# phase 2 - try to optimize for O(n) complexity.
# keep a running tally of the largest sum, one variable should track the largest
# sum so far and another to track the current sum

def largest_contiguous_subsum_2(array)
    largest_sum = array.first ; current_sum = array.first

    (1...array.length).each do |i|
        ele = array[i]
        current_sum += ele
        current_sum = ele if current_sum < ele
        largest_sum = current_sum if largest_sum < current_sum
    end

    largest_sum
end

puts "-----"
puts "complexity of largest_contiguous_subsum_2 is is O(n) because we're only iterating through the array once. Space complexity is O(1) because we're only storing integer pointers, and because comparisons are cheap"
p largest_contiguous_subsum_2(list1)
p largest_contiguous_subsum_2(list2)
p largest_contiguous_subsum_2(list3)