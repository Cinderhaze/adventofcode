#!/usr/bin/env ruby

require 'getoptlong'

class Pair
  attr_reader :x, :y

  def initialize(input)
    @x=input.split(',')[0].to_i
    @y=input.split(',')[1].to_i
  end

  def to_s
    "#{@x},#{@y}"
  end
end

class Light
  def initialize()
    @light=false
  end

  def on?()
    return @light
  end

  def on()
    @light = true
  end

  def off()
    @light = false
  end

  def toggle()
    @light = !@light
  end
end

class Inst
  attr_reader :cmd, :begin, :end

  def initialize(inst)
    parseInst(inst)
  end

  def parseInst(inst)
    #use a regex to create three matchgrups
    /(?<cmd>.*)\s(?<start>\d*,\d*) through (?<stop>\d*,\d*)/ =~ inst
    @cmd=cmd
    @begin=Pair.new(start)
    @end=Pair.new(stop)
  end
end

class Grid
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
    @grid.values.count(&:on?) 
  end
end

class Day6
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

  input_name = 'day6.input.txt'
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
  
  ans = Day6.new(input)
  ans.calc()

end
