#!/usr/bin/env ruby

require 'getoptlong'
require 'set'

class Day10
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

  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day10.input.txt'
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
  
  ans = Day10.new(input)
  ans.calc()

end
