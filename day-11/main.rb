input = open('./input.txt').readlines.map{ |e| e == "\n" ? e : e.chomp }
D = true

class Monkey
    attr_accessor :name, :items, :item_count

    def initialize(name, items, operator, modifier, mod, t_monkey, f_monkey)
        @name = name
        @items = items
        @operator = operator
        @modifier = modifier
        @mod = mod
        @t_monkey = t_monkey
        @f_monkey = f_monkey
        @item_count = 0
    end

    def inspect(item)
        @item_count += 1
        if @modifier =='old'
            return item.method(@operator).(item) / 3
        else
            return item.method(@operator).(@modifier.to_i) / 3
        end
    end

    def test(item)
        return item % @mod == 0 ? @t_monkey : @f_monkey
    end

    def to_s
        "Monkey #{@name}: #{@items}, inspected items #{@item_count} times."
    end
end

# import monkeys
monkeys = []

name, items, op, modifier, mod, tr, fa = nil
input.each do | line |
    
    if line.include?('Monkey')
        name = line.split(' ')[1][0..-2].to_i
    elsif line.include?('items')
        items = line.split(':')[1].split(',').map{ |e| e.to_i }
    elsif line.include?('Operation')
        op = line.split(':')[1].split('=')[1].split(' ')[1]
        modifier = line.split(':')[1].split('=')[1].split(' ')[2]
    elsif line.include?('Test')
        mod = line.split(' ')[-1].to_i
    elsif line.include?('true')
        tr = line.split(' ')[-1].to_i
    elsif line.include?('false')
        fa = line.split(' ')[-1].to_i
    elsif line == "\n"
        monkeys << Monkey.new(name, items, op, modifier, mod, tr, fa)
        name, items, op, modifier, mod, tr, fa = nil
    end
end
monkeys << Monkey.new(name, items, op, modifier, mod, tr, fa)

puts monkeys

# 20 turns
20.times do    
    monkeys.each do | monkey |
        while monkey.items.count > 0 do
            item = monkey.items.shift
            puts "Monkey #{monkey.name} looking at #{item}" if D
            item = monkey.inspect(item)
            puts "Monkey causes worry level to go to #{item} (/3 included)" if D
            to_monkey = monkey.test(item)
            puts "Monkey determines it needs to go to Monkey #{to_monkey}" if D
            catch_monkey = monkeys.select{ |m| m.name == to_monkey }.first
            puts "Monkey found as #{catch_monkey}" if D
            catch_monkey.items << item
        end
    end
end

monkeys.sort!{ |a, b| b.item_count <=> a.item_count }

puts "Part 1: Monkey Business Level = #{monkeys[0].item_count * monkeys[1].item_count}"