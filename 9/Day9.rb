#!/usr/bin/env ruby

require 'getoptlong'
require 'set'

class Inst
  attr_reader :first, :second, :dist

  def initialize(inst)
    parseInst(inst)
  end

  def parseInst(inst)
    #use a regex to create three matchgrups
    /(?<first>.*) to (?<second>.*) = (?<dist>\d*)/ =~ inst
    @first=first
    @second=second
    @dist=dist.to_i
  end
  
  def loc_array()
    [@first, '->',@second]
  end
end

class Graph
  attr_reader :input
  
  def initialize()
    @lookup = Hash.new 
    @locs = Set.new
    @results = Hash.new
  end

  def step(instruction)
    inst = Inst.new(instruction)
    #insert the 'distance' with both digraphs
    @lookup[inst.loc_array.join] = inst.dist
    @lookup[inst.loc_array.reverse.join] = inst.dist

    #Keep track of each location
    @locs << inst.first
    @locs << inst.second
    
  end

  def calc()
    # Actually calculate all possible paths, to find the shortest one
#    puts @lookup
    @locs.to_a.permutation.each do |path|
      dist=0
      path.each_cons(2) do |a,b|
        #lookup the distance
#        puts "looking up #{a}->#{b}"
        step_dist = @lookup["#{a}->#{b}"]
        if step_dist
          dist += @lookup["#{a}->#{b}"]
        else
          puts "No path from #{a}->#{b}"
          break
        end
      end
      @results[path.join("->")]=dist
    end
#    puts @results
  end

  def shortest_route
    @results.values.min
  end

end

class Day9
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()

    graph = Graph.new()
    @input.each_line do |line|
      graph.step(line)
    end

    graph.calc()

    puts "shortest path is #{graph.shortest_route}"

  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day9.input.txt'
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
  
  ans = Day9.new(input)
  ans.calc()

end
