input = open('./input.txt').readlines.map{ |e| e.split(' ')}.map{ |e| [e[0], e[1].to_i] }
D = false

