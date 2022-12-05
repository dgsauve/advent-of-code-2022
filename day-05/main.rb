input = open('./input.txt').readlines

# parse the initial state

def get_state(input)
    state = []
    instruction_line = nil
    input.each_with_index do | line, index |
        # Break at instruction
        if line == "\n"
            instruction_line = index + 1
            break
        end
        line = line.scan(/(\[\S\]|\ \ \ \ |\ \d\ )/)
        state << line
    end

    state = state.transpose.map(&:reverse)
    state.each_with_index do | arr, ix |
        arr.flatten!
        arr.delete("    ")
        arr.map!{ |el| el.sub("[", '').sub("]", '') }
    end
    return state, instruction_line
end

state, instruction_line = get_state(input)

input[instruction_line..-1].each do | i |
    instruction_set = i.scan(/\d{1,2}/).map!{ |el| el.to_i}
    # move how many
    instruction_set[0].times do 
        crate = state[instruction_set[1] - 1].pop
        state[instruction_set[2] - 1] << crate 
    end
end

top_stack = ""

state.each do |col| 
    top_stack += col[-1]
end

puts "part 1: #{top_stack}"
# WQJBBLMJT not right
# RLFNRTNFB is correct

# part 2

state, instruction_line = get_state(input)

input[instruction_line..-1].each do | i |
    instruction_set = i.scan(/\d{1,2}/).map!{ |el| el.to_i}
    puts instruction_set.inspect
    crate = state[instruction_set[1] - 1].pop(instruction_set[0])
    state[instruction_set[2] - 1] += crate 
end

puts "modified:", state.inspect

top_stack = ""

state.each do |col| 
    top_stack += col[-1]
end

puts "part 2: #{top_stack}"