input = open('./input.txt').readlines.map!{ |l| l }
priorities = {}
('a'..'z').each_with_index { | l, i | priorities[l] = i + 1 }
('A'..'Z').each_with_index { | l, i | priorities[l] = i + 27 }

sum = 0
input.each do | rucksack |
    rucksack.chomp!
    rucksack = rucksack.split('')
    c1 = rucksack[0...(rucksack.length/2)].uniq
    c2 = rucksack[(rucksack.length/2)..-1].uniq
    # puts c1.inspect, c2.inspect
    rucksack = c1 + c2
    items = rucksack.select{ |i| rucksack.count(i) > 1 }.uniq
    items.each do | item |
        sum += priorities[item]
    end
end

puts "part 1: #{sum}"

sum = 0
(2...input.length).step(3) do | i |
    rall = (input[i - 2].chomp).split('').uniq
    rall += (input[i - 1].chomp).split('').uniq
    rall += (input[i].chomp).split('').uniq
    badge = rall.select{ |i| rall.count(i) == 3 }.uniq.first
    sum += priorities[badge]
end

puts "part 2: #{sum}"