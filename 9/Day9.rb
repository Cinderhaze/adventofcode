#!/usr/bin/env ruby

require 'getoptlong'

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
end

class Graph
  attr_reader :input
  
  def initialize()
    @grid = Hash.new { |h,k| h[k] = Light.new() }
  end

  def step(instruction)
    inst = Inst.new(instruction)

    #for now, just have it operate on the first location given, we'll properly fix this later

    (inst.begin.x..inst.end.x).each do |x|
      (inst.begin.y..inst.end.y).each do |y|
#        puts "Operate on #{x},#{y}"
        loc = "#{x},#{y}"
        case inst.cmd
        when 'toggle'
          @grid[loc].toggle
        when 'turn off'
          @grid[loc].off
        when 'turn on'
          @grid[loc].on
        end
      end
    end
   # puts @grid
  end

  def num_on()
    #this will count the number of entries similar to .count { |l| l.on? }
    # more concise than better than my .select{ |l| l.on? }.size, thanks Jeg2!
    #@grid.values.count(&:on?) 
    sum = 0
    @grid.values.each {|light| sum += light.on?}
    sum
  end
end

class Day9
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()

    grid = Grid.new()
    @input.each_line do |line|
      grid.step(line)
    end

    puts "#{grid.num_on} lights are lit"

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
