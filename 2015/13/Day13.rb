#!/usr/bin/env ruby

require 'getoptlong'
require 'set'

# shamelessly pulled from https://www.ruby-forum.com/topic/106362
module Enumerable
   def each_cycle(window, start=0)
     wrap_start = []
     cache = []
     each_with_index do |e,i|
       cache << e
       if i >= start + (window - 1)
         yield cache[start, window]
         cache.shift
       else
         wrap_start << e
       end
     end
     wrap_start.each do |e|
       cache << e
       yield cache[start, window]
       cache.shift
     end
     self
   end
end

class Inst
  attr_reader :first, :second, :happiness

  def initialize(inst)
    parseInst(inst)
  end

  def parseInst(inst)
    #use a regex to create three matchgrups
    /(?<first>.*) would (?<sign>gain|lose) (?<happiness>\d+) happiness units by sitting next to (?<second>.*)./ =~ inst
    @first=first
    @second=second
    @happiness=happiness.to_i
    @happiness *= -1 if sign == 'lose' 
  end
  
  def loc_array()
    [@first, '->',@second]
  end
end

class Graph
  attr_reader :input
  
  def initialize()
    @lookup = Hash.new(0) 
    @locs = Set.new
    @results = Hash.new
  end

  def step(instruction)
    inst = Inst.new(instruction)
    @lookup[inst.loc_array.join] = inst.happiness

    #Keep track of each location
    @locs << inst.first
    @locs << inst.second
    
  end

  def calc()
    # Actually calculate all possible paths, to find the shortest one
#    puts @lookup
    @locs.to_a.permutation.each do |path|
      total_happiness = arrangement_happiness(path)
      @results[path.join("->")]=total_happiness
    end
#    puts @results
  end

  def pair_happiness
  end

  def arrangement_happiness(seating)
    total_happiness=0
    #puts "---#{seating}---"
    seating.each_cycle(3) do |left,center,right|
      #lookup the happiness for each person
      happiness_l = @lookup["#{center}->#{left}"]
      happiness_r = @lookup["#{center}->#{right}"]
      #puts "From #{center} to #{left} -> #{happiness_l}"
      #puts "From #{center} to #{right} -> #{happiness_r}"
      happiness = happiness_l + happiness_r
      total_happiness += happiness
    end
    #puts total_happiness
    total_happiness
  end

  def shortest_route
    @results.values.min
  end

  def longest_route
    @results.values.max
  end

  def add_me
    #distance default to 0, and add me to loc
    @locs << 'me'
    @results = {} # reset to remove previous calculation results
#    puts @locs.to_a
  end

end

class Day13
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
    puts "longest path is #{graph.longest_route}"

    graph.add_me()
    graph.calc()

    puts "After adding myself"
    puts "shortest path is #{graph.shortest_route}"
    puts "longest path is #{graph.longest_route}"

  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day13.input.txt'
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
  
  ans = Day13.new(input)
  ans.calc()

end
