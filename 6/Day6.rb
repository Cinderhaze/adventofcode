m t#!/usr/bin/env ruby

require 'getoptlong'

class Grid
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def step(instruction)
  end

  def on()
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

    puts "#{grid.on} lights are lit"
    count

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
