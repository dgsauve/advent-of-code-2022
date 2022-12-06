input = open('./input.txt').readline.split('')

def signal_scanner(input, length)
    marker = nil
    scan = input[0..(length - 1)]
    input[length..-1].each_with_index do | signal, ix |
        if scan.uniq.length == scan.length
            marker = ix + length
            return marker
        else
            scan = scan.drop(1)
            scan << signal
        end
    end

    marker
end

puts "part 1: #{signal_scanner(input, 4)}"
puts "part 2: #{signal_scanner(input, 14)}"