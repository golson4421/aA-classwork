## Phase 1:
# Write a method #first_anagram? that will generate and store all the possible anagrams of the first string.
# Check if the second string is one of these.

def first_anagram?(str1, str2)
    anagrams_of_str1 = str1.split("").permutation.map(&:join)
    anagrams_of_str1.include?(str2)
end

puts "-----"
puts "first_anagram method has complexity O(2*n!), once because finding the permutations of str1 is O(n!),"
puts "then running include on an array of n! substrings to find str2"
p first_anagram?("gizmo", "sally")
p first_anagram?("elvis", "lives")


## Phase 2:

def second_anagram?(str1, str2)
    str1.each_char do |char|
        str2_idx = str2.index(char)
        str2.slice!(str2_idx) unless str2_idx.nil?
    end
    str2 == ""
end

puts "-----"
puts "second_anagram has complexity O(n*m), n because we're iterating through str1,"
puts "then finding the index in str2 which multiplies the complexity by length of str2"
p second_anagram?("gizmo", "sally")
p second_anagram?("elvis", "lives")


## Phase 3

def third_anagram?(str1, str2)
    sorted1 = str1.chars.sort.join
    sorted2 = str2.chars.sort.join
    sorted1 == sorted2
end


puts "-----"
puts "third_anagram: sorting the chars before comparison has complexity O(n log n + m log m),"
puts "so it's slightly better than second_anagram for short strings & much better for longer ones"
p third_anagram?("gizmo", "sally")
p third_anagram?("elvis", "lives")



## Phase 4

def fourth_anagram?(str1, str2)
    count1 = Hash.new(0)
    count2 = Hash.new(0)
    str1.each_char { |char| count1[char] += 1 }
    str2.each_char { |char| count2[char] += 1 }
    count1 == count2
end

puts "-----"
puts "fourth_anagram: creating the two hashes takes O(n+m) complexity, and comparing them is negligible."
p fourth_anagram?("gizmo", "sally")
p fourth_anagram?("elvis", "lives")