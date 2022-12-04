POINTS = {
    "X" => 1,
    "Y" => 2,
    "Z" => 3
}
LOSS_VALUE = 0
DRAW_VALUE = 3
WIN_VALUE = 6

# Rock
A = {
    'X' => DRAW_VALUE,
    'Y' => WIN_VALUE,
    'Z' => LOSS_VALUE
}
# Paper
B = {
    'X' => LOSS_VALUE,
    'Y' => DRAW_VALUE,
    'Z' => WIN_VALUE
}
# Scissors
C = {
    'X' => WIN_VALUE,
    'Y' => LOSS_VALUE,
    'Z' => DRAW_VALUE
}

input = open('./input.txt').readlines.map{ |i| i = i.split(' ') }

# puts input.inspect

def move_points(movearray, round)
    return_points = movearray[round[1]]
    return_points += POINTS[round[1]]
    return_points
end

points = 0
input.each do | round |
    if round[0] == 'A'
        points += move_points(A, round)
    elsif round[0] == 'B'
        points += move_points(B, round)
    elsif round[0] == 'C'
        points += move_points(C, round)
    end
end

# part 1
puts "part 1: #{points}"

def get_move_points(movearray, round)
    return_points = 0
    if round[1] == 'X' # lose
        move = movearray.key(LOSS_VALUE)
        return_points += LOSS_VALUE
        return_points += POINTS[move]
    elsif round[1] == 'Y' # draw
        move = movearray.key(DRAW_VALUE)
        return_points += DRAW_VALUE
        return_points += POINTS[move]
    elsif round[1] == 'Z' # win
        move = movearray.key(WIN_VALUE)
        return_points += WIN_VALUE
        return_points += POINTS[move]
    end

    return_points
end

points = 0 # always remember to reset your points value :|
input.each do | round |
    if round[0] == 'A'
        points += get_move_points(A, round)
    elsif round[0] == 'B'
        points += get_move_points(B, round)
    elsif round[0] == 'C'
        points += get_move_points(C, round)
    end
end

puts "part 2: #{points}"
# 22991 too high
# 10835 correct