#!/usr/bin/env ruby

require 'getoptlong'

class Santa
  attr_reader :name, :visited
  
  def initialize(name)
    @name = name
    @visited = Hash.new(0)

    @x = 0
    @y = 0

    #visit the initial house
    loc = "(#{@x},#{@y})"
    @visited[loc] += 1

  end

  def step(input)

    #follow directions
    case input
     when '^'
       @y+=1
     when 'v'
       @y-=1
     when '<'
       @x-=1
     when '>'
       @x+=1
     end
     loc = "(#{@x},#{@y})"
     @visited[loc] += 1
  end

  def to_s
    puts "#{name} Visited: #{@visited}"
    puts "Number of houses visited by #{name}: #{@visited.keys.size}"

  end
end

class Day3
  attr_reader :input, :visited
  
  def initialize(input)
    @input = input
    @visited = Hash.new(0)
  end

  def calc()

    santa = Santa.new('santa')
    robo = Santa.new('robo-santa')

    santas = [ santa, robo ]
    count = 0

    #follow directions
    @input.each_char do |c|
      santas[count%2].step(c)
      count += 1
    end

    puts "#{santa.name} Visited: #{santa.visited}"
    puts "#{robo.name} Visited: #{robo.visited}"

    puts "#{santa.name} visited houses: #{santa.visited.keys.size}"
    puts "#{robo.name} visited houses: #{robo.visited.keys.size}"

    both = santa.visited.merge(robo.visited) 
   
    puts "visited houses: #{both.keys.size}"

  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day3.input.txt'
  input = nil
  
  opts.each do |opt, arg|
    case opt
      when '--file'
        input_name = arg.to_s
      when '--input'
        input = arg.to_s
    end
  end

  if !input 
    input = IO.read(input_name)
  end
  
  ans = Day3.new(input)
  ans.calc()

end
