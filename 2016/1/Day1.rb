#!/usr/bin/env ruby

require 'getoptlong'
require 'pp'

class Taxicab
  attr_reader :result

  def initialize(input)
    @input = input
    @dir = Direction.new
    @vectors = sequence_to_vectors(input.split(', '))
  end

  def sequence_to_vectors(seq)
    seq.each_with_object([]) do |step, memo|
      /(?<orientation>[LR])(?<size>\d*)/ =~ step
    
      memo << [orientation, size.to_i]
    end
  end

  def distance
    h = Hash.new{ |hash, key| hash[key] = 0 }
    @vectors.each_with_object(h) do |dist, memo|
      
      orientation = case dist.first
      when 'L'
        @dir.prev
      when 'R'
        @dir.next
      end
      memo[orientation] += dist.last
    end 

    pp h
    (h[:north] - h[:south]).abs + (h[:east] - h[:west]).abs
  end

  def track_path
  end

end

class Direction
  def initialize()
    @pos = 0
    @direction = [:north, :east, :south, :west]
  end

  def next
    @pos = (@pos + 1) % @direction.length 
    @direction[@pos]
  end
  def prev
    @pos = (@pos - 1) % @direction.length 
    @direction[@pos]
  end
end

class Day1
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()
    tc = nil
    @input.each_line do |line|
      tc = Taxicab.new(line)
    end
    tc.distance
  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--number', '-n', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'input.txt'
  input = nil
  num=1
  
  opts.each do |opt, arg|
    case opt
      when '--file'
        input_name = arg.to_s
      when '--input'
        input = arg.to_s
      when '--number'
        num = arg.to_i
    end
  end

  if !input 
    input = IO.read(input_name)
  end
  
  ans = Day1.new(input)
  dist = ans.calc()
  puts "Distance traveled is #{dist}"

end
