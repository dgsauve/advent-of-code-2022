input = open('./input.txt').readlines.map{ |el| el.chomp.split('').map { |ee| ee.to_i} }

visible_trees = 0

input.each_with_index do | row, rix |
    if rix == 0 or rix == input.length - 1
        visible_trees += row.count
    else
        row.each_with_index do | tree, cix |
            if cix == 0 or cix == row.length - 1
                visible_trees += 1
            else
                can_see = false
                visible = true
                # up
                (0..(rix - 1)).each do |ix|
                    visible = false if input[ix][cix] >= tree
                end
                if visible
                    visible_trees += 1 unless can_see
                    can_see = true
                end
                visible = true
                # down
                ((rix + 1)..(input.length - 1)).each do |ix|
                    visible = false if input[ix][cix] >= tree
                end
                if visible
                    visible_trees += 1 unless can_see
                    can_see = true
                end
                visible = true
                # left
                (0..(cix - 1)).each do |ix|
                    visible = false if input[rix][ix] >= tree
                end
                if visible
                    visible_trees += 1 unless can_see
                    can_see = true
                end
                visible = true
                # right
                ((cix + 1)..(row.length - 1)).each do |ix|
                    visible = false if input[rix][ix] >= tree
                end
                if visible
                    visible_trees += 1 unless can_see
                    can_see = true
                end
            end
        end
    end
end

puts "\n\npart 1: #{visible_trees}"

scenic_score = 0

input.each_with_index do | row, rix |
    if rix == 0 or rix == input.length - 1
        # nothing
    else
        row.each_with_index do | tree, cix |
            if cix == 0 or cix == row.length - 1
                # nothing
            else
                u_dist = 0
                d_dist = 0
                l_dist = 0
                r_dist = 0
                # up
                (0..(rix - 1)).reverse_each do |ix|
                    u_dist += 1
                    break if input[ix][cix] >= tree
                end
                # down
                ((rix + 1)..(input.length - 1)).each do |ix|
                    d_dist += 1
                    break if input[ix][cix] >= tree
                end
                # left
                (0..(cix - 1)).reverse_each do |ix|
                    l_dist += 1
                    break if input[rix][ix] >= tree
                end
                # right
                ((cix + 1)..(row.length - 1)).each do |ix|
                    r_dist += 1
                    break if input[rix][ix] >= tree
                end
                tree_scenic_score = u_dist * d_dist * l_dist * r_dist
                scenic_score = tree_scenic_score if tree_scenic_score > scenic_score
            end
        end
    end
end

puts "\n\npart 2: #{scenic_score}"