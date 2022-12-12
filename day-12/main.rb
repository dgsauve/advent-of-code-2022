input = open('./input.txt').readlines.map{ |e| e.chomp }
                                        .map{ |e| e.split('') }
                                        .map { |e| e.map{ |ee| ee == 'S' ? 1 : ee } }
D = true

puts input.inspect if D

def print_map(input)
    input.each do | row |
        row.each do | item |
            print "#{item}".rjust(2)
        end
        puts "\n"
    end
end

def coordinates_adjacent_to_value(array, coordinates, value)
    if array[coordinates[0] + 1][coordinates[1]] == value
        return true
    elsif array[coordinates[0] - 1][coordinates[1]] == value
        retrun true
    elsif array[coordinates[0]][coordinates[1] + 1] == value
        return true
    elsif array[coordinates[0]][coordinates[1] - 1] == value
        return true
    else
        return false
    end
end



print_map(input)

# first step taken by .map above
solved = false
elevation = 'a'
active_locations = []
last_step = 1



until solved do
    input.each_with_index do | row, rix |
        break if solved
        row.each_with_index do | step, cix |
            break if solved
            if !active_locations.include?([rix, cix]) && step.is_a?(Integer) && step == last_step
                puts "checking [#{rix}, #{cix}]"
                # check for available steps around
                unless rix == 0
                    if input[rix-1][cix].is_a?(String)
                        if elevation.next == input[rix-1][cix] || input[rix-1][cix] <= elevation
                            if input[rix-1][cix] == 'z'
                                if coordinates_adjacent_to_value(array, [rix - 1, cix], 'E')
                                    solved = true
                                    puts "SOLVED" if D
                                end
                            end
                            elevation = input[rix-1][cix]
                            input[rix-1][cix] = input[rix][cix] + 1
                            last_step = input[rix][cix] + 1
                            active_locations << input[rix-1][cix]
                        end
                    end
                end
                unless rix == input.length - 1
                    if input[rix+1][cix].is_a?(String)
                        if elevation.next == input[rix+1][cix] || input[rix+1][cix] == elevation
                            if input[rix+1][cix] == 'z'
                                if coordinates_adjacent_to_value(input, [rix + 1, cix], 'E')
                                    solved = true
                                    puts "SOLVED" if D
                                end
                            end
                            elevation = input[rix+1][cix]
                            input[rix+1][cix] = input[rix][cix] + 1
                            last_step = input[rix][cix] + 1
                            active_locations << input[rix+1][cix]
                        end
                    end
                end
                unless cix == 0
                    if input[rix][cix-1].is_a?(String)
                        if elevation.next == input[rix][cix-1] || input[rix][cix-1] == elevation
                            if input[rix][cix-1] == 'z'
                                if coordinates_adjacent_to_value(array, [rix, cix-1], 'E')
                                    solved = true
                                    puts "SOLVED" if D
                                end
                            end
                            elevation = input[rix][cix-1]
                            input[rix][cix-1] = input[rix][cix] + 1
                            last_step = input[rix][cix] + 1
                            active_locations << input[rix][cix-1]
                        end
                    end
                end
                unless cix == row.length - 1
                    if input[rix][cix+1].is_a?(String)
                        if elevation.next == input[rix][cix+1] || input[rix][cix+1] == elevation
                            if input[rix][cix+1] == 'z'
                                if coordinates_adjacent_to_value(array, [rix, cix+1], 'E')
                                    solved = true
                                    puts "SOLVED" if D
                                end
                            end
                            elevation = input[rix][cix+1]
                            input[rix][cix+1] = input[rix][cix] + 1
                            last_step = input[rix][cix] + 1
                            active_locations << input[rix][cix+1]
                        end
                    end
                end
                print_map(input)
                # gets
            end
        end
    end
    active_locations = []
end

print_map(input)

puts "part 1: #{last_step}"