input = open('./input.txt').readlines.map{ |el| el.chomp.split('').map { |ee| ee.to_i} }

puts input.inspect

visible_trees = 0

input.each_with_index do | row, rix |
    if rix == 0 or rix == input.length - 1
        visible_trees += row.count
        puts "row"
    else
        row.each_with_index do | tree, cix |
            if cix == 0 or cix == row.length - 1
                visible_trees += 1
                puts "col"
            else
                puts "looking at [#{rix}, #{cix}]"
                visible = true
                # up
                (0..(rix - 1)).each do |ix|
                    visible = false if input[ix][cix] >= tree
                end
                if visible
                    puts "visible"
                    visible_trees += 1
                    break
                end
                visible = true
                # down
                ((rix + 1)..(input.length - 1)).each do |ix|
                    visible = false if input[ix][cix] >= tree
                end
                if visible
                    visible_trees += 1
                    break
                end
                visible = true
                # left
                (0..(cix - 1)).each do |ix|
                    visible = false if input[rix][ix] >= tree
                end
                if visible
                    visible_trees += 1
                    break
                end
                visible = true
                # right
                ((cix + 1)..(row.length - 1)).each do |ix|
                    visible = false if input[rix][ix] >= tree
                end
                if visible
                    visible_trees += 1
                    break
                end
            end
        end
    end
end

puts "\n\npart 1: #{visible_trees}"