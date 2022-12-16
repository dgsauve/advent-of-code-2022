input = open('./input.txt').readlines.map{ |e| e.split(' ')}.map{ |e| [e[0], e[1].to_i] }
D = false

path = [[0,0]]
t = [0,0]
h = [0,0]

def x_adjacent(p1, p2)
    (p1[0] - 1) <= p2[0] && (p1[0] + 1)  >= p2[0]
end

def y_adjacent(p1, p2)
    (p1[1] - 1) <= p2[1] && (p1[1] + 1)  >= p2[1]
end

def are_adjacent(p1, p2)
    x_adjacent(p1, p2) && y_adjacent(p1, p2)
end

input.each do | step |
    direction, distance = step
    distance.times do
        case direction
        when 'R'
            t[0] += 1
        when 'L'
            t[0] -= 1
        when 'U'
            t[1] += 1
        when 'D'
            t[1] -= 1
        end
        # check if h is adjacent to t
        unless are_adjacent(t, h)
            if !x_adjacent(t, h) && t[1] == h[1]
                puts "moving h x 1" if D
                t[0] > h[0] ? h[0] += 1 : h[0] -= 1
                puts h.inspect if D
            elsif t[0] == h[0] && !y_adjacent(t, h)
                puts "moving h y 1" if D
                t[1] > h[1] ? h[1] += 1 : h[1] -= 1
            else
                puts "moving h diagonally" if D
                t[0] > h[0] ? h[0] += 1 : h[0] -= 1
                t[1] > h[1] ? h[1] += 1 : h[1] -= 1
            end
            path << h.clone
        end
    end
end

puts "part 1: #{path.uniq.count} 😭 part 2 omg"

path = [[0,0]]
rope = [
    [0,0],
    [0,0],
    [0,0],
    [0,0],
    [0,0],
    [0,0],
    [0,0],
    [0,0],
    [0,0],
    [0,0]
]

input.each do | step |
    direction, distance = step
    distance.times do
        case direction
        when 'R'
            rope[0][0] += 1
        when 'L'
            rope[0][0] -= 1
        when 'U'
            rope[0][1] += 1
        when 'D'
            rope[0][1] -= 1
        end
        # check if h is adjacent to t
        rope[1..-1].each_with_index do | h, ix |
            t = rope[ix]
            unless are_adjacent(t, h)
                if !x_adjacent(t, h) && t[1] == h[1]
                    puts "moving h x 1" if D
                    t[0] > h[0] ? h[0] += 1 : h[0] -= 1
                    puts h.inspect if D
                elsif t[0] == h[0] && !y_adjacent(t, h)
                    puts "moving h y 1" if D
                    t[1] > h[1] ? h[1] += 1 : h[1] -= 1
                else
                    puts "moving h diagonally" if D
                    t[0] > h[0] ? h[0] += 1 : h[0] -= 1
                    t[1] > h[1] ? h[1] += 1 : h[1] -= 1
                end
                path << h.clone if ix == rope[1..-1].count - 1
            end
        end
    end
end

puts "part 2: #{path.uniq.count}"
# 8383 too high