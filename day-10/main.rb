input = open('./input.txt').readlines.map{ |e| e.chomp }
D = false

x = 1
cycle = 0
cycles = [20, 60, 100, 140, 180, 220]
vals = []
# For now, consider the signal strength (the cycle number multiplied by the value of the X register) 
# during the 20th cycle and every 40 cycles after that 
# (that is, during the 20th, 60th, 100th, 140th, 180th, and 220th cycles).

input.each do | inst |
    if inst == 'noop'
        cycle += 1
            # check for cycle value
        if cycles.include?(cycle)
            vals << cycle * x
        end
    else
        cycle += 1
        # check for cycle value
        if cycles.include?(cycle)
            vals << cycle * x
        end
        cycle += 1
        if cycles.include?(cycle)
            vals << cycle * x
        end
        x += inst.split(' ')[1].to_i
    end
end

puts "part 1: #{vals.sum}"

x = 1
cycle = 0

output = ''

def parse_cycle(cycle, x)
    return_string = ''
    if cycle % 40 == x - 1 || cycle % 40 == x or cycle % 40 == x + 1
        return_string += '#'
    else
        return_string += '.'
    end
    if cycle % 40 == 0 && cycle != 0
        return_string += "\n"
    end

    return_string
end

input.each do | inst |
    if inst == 'noop'
        output += parse_cycle(cycle, x)
        cycle += 1
    else
        output += parse_cycle(cycle, x)
        cycle += 1
        # check for cycle value
        
        output += parse_cycle(cycle, x)
        cycle += 1
        # check for cycle value

        x += inst.split(' ')[1].to_i
    end
end

puts output