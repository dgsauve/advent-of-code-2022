require 'json'
input = open('./input.txt').readlines

pairs = []
indicies = []

input.each do | single |
    unless single == "\n"
        single.chomp!
        pairs << JSON.parse(single)
    end
end

# puts pairs.inspect

def check_order(left, right)
    ret_val = true
    left.each_with_index do | l, index |
        if left[index].is_a?(Integer) and right[index].is_a?(Integer)
            ret_val = false if left[index] > right[index]

        elsif left[index].is_a?(Array) and right[index].is_a?(Array)
            if right[index].length == 0 and left[index].length != 0
                ret_val = false
            else
                ret_val = check_order(left[index], right[index])
            end

        elsif left[index].is_a?(Array) and right[index].is_a?(Integer)
            ret_val = check_order(left[index], [right[index]])

        elsif left[index].is_a?(Integer) and right[index].is_a?(Array)
            ret_val = check_order([left[index]], right[index])
        end
    end
    ret_val
end

(0...pairs.length).step(2).each do | index |
    left = pairs[index]
    right = pairs[index + 1]

    if left.length <= right.length and check_order(left, right)
        indicies << (index / 2) + 1
    end
end

# puts indicies.inspect

puts "part 1: #{indicies.sum}"
# 2728 too low