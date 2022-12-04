input = open('./input.txt').readlines

elves = []

total = 0

input.each do | snack |
    unless snack == "\n"
        total += snack.to_i
    else
        elves << total
        total = 0
    end
end

# part 1
puts elves.each_with_index.max

ordered_elves = elves.each_with_index.sort{ |a,b| b[0] <=> a[0] }

sum = 0
ordered_elves[0..2].each do | elf |
    sum += elf[0]
end

puts sum