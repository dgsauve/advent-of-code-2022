require 'matrix'

input = open('./input.txt').readlines.map{ |l| l.chomp }

class Dir
    attr_reader :name, :parent, :dirs, :files

    def initialize(name, parent=nil)
        @name = name
        @parent = parent
        @files = []
        @dirs = []
    end

    def size(sum=0)
        sum += @files.sum(&:size)
        @dirs.each do |dir|
            sum += dir.size
        end
        return sum
    end

    def to_s(indent = 0)
        s = "\t" * indent + "#{@name}: #{files.count} - #{dirs.count} - #{self.size}"
        @files.each do | f |
            s += "\n" + "\t" * (indent + 1) + "#{f}"
        end
        @dirs.each do | dir |
            s += "\n"
            s += dir.to_s(indent + 1)
        end

        s
    end
end

class Fl
    attr_reader :name, :size

    def initialize(name, size)
        @name = name
        @size = size.to_i
    end

    def to_s
        "#{size} #{name}"
    end
end

home_dir = Dir.new('/')
active_dir = home_dir

input.each do | command |
    # puts "command: #{command}"
    if (command[0] == '$')
        # Handle cd command
        if command[2..3] == "cd"
            if command[5..-1] == ".."
                # puts "changing up to #{active_dir.parent}"
                active_dir = active_dir.parent
            elsif command [5..-1] == "/"
                
            else
                # puts "changing down to #{command[5..-1]}"
                active_dir = active_dir.dirs.select{|d| d.name == command[5..-1]}[0]
                # puts active_dir
            end
        # handle ls command
        elsif command[0..1] == "ls"
            
        end
    else
        # handle dir output
        if command[0..2] == "dir"
            active_dir.dirs << Dir.new(command.split(' ')[1], active_dir)
        else # handle file output
            active_dir.files << Fl.new(command.split(' ')[1], command.split(' ')[0])
        end
    end
end

puts "\n\n===\n\n"

sum = 0
LIMIT = 100000

if home_dir.size <= LIMIT
    sum += home_dir.size
end

def get_dir_total(dir, sum, limit)
    dir.dirs.each do | d |
        sum += d.size if d.size <= limit
        sum = get_dir_total(d, sum, limit)
    end
    
    sum
end

File.open("struct.txt", "w+") do |f|
    f.puts(home_dir)
end

sum = get_dir_total(home_dir, sum, LIMIT)

puts "part 1: sum #{sum}"

# PART 2

SYSTEM = 70000000
T_FREE = 30000000

target = T_FREE - (SYSTEM - home_dir.size)

puts "target #{target}"

def get_beeg_dirs(dir, target)
    possible_dirs = []
    dir.dirs.each do | d |
        possible_dirs << d if d.size >= target
        possible_dirs += get_beeg_dirs(d, target)
    end
    
    possible_dirs
end

possible_dirs = get_beeg_dirs(home_dir, target)

puts possible_dirs.count

possible_dirs.sort!{ |a,b| a.size <=> b.size }

puts "part 2"

possible_dirs.each do |d|
    puts "#{d.name}\t\t#{d.size}"
end

# cmvqf too high 36358362
