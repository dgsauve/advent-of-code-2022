input = open('./input.txt').readlines
    .map{|e| (e.chomp).split(',')
        .map{ |ee| ee.split('-')
            .map {|eee| eee.to_i } 
            } 
        }

count = 0
input.each do | pair |
    # check first assignment for second
    if pair[0][0] <= pair[1][0] && pair[0][1] >= pair[1][1]
        count += 1
    elsif pair [1][0] <= pair[0][0] && pair[1][1] >= pair[0][1]
        count += 1
    end
end

puts "part 1: #{count}"

count = 0
input.each do | pair |
    # check first assignment for second
    if pair[0][0].between?(pair[1][0], pair[1][1]) || pair[0][1].between?(pair[1][0], pair[1][1])
        count += 1
    elsif pair[1][0].between?(pair[0][0], pair[0][1]) || pair[1][1].between?(pair[0][0], pair[0][1])
        count += 1
    end
end

puts "part 2: #{count}"