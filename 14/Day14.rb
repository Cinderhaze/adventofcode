#!/usr/bin/env ruby

require 'getoptlong'

class Inst
  attr_reader :name, :speed, :duration, :rest

  def initialize(inst)
    parseInst(inst)
  end

  def parseInst(inst)
    #use a regex to create matchgrups
    /(?<name>.*) can fly (?<speed>\d+) km\/s for (?<duration>\d+) seconds, but then must rest for (?<rest>\d+) seconds./ =~ inst
    @name = name
    @speed = speed.to_i
    @duration = duration.to_i
    @rest = rest.to_i
  end
  
end

class Reindeer
  attr_reader :name, :speed, :duration, :rest, :inst

  def initialize(inst)
    @inst = Inst.new(inst)
    @name = @inst.name
    @speed = @inst.speed.to_i
    @duration = @inst.duration.to_i
    @rest = @inst.rest.to_i
  end

  def loc(sec)
    step = @duration + @rest
    num_steps = sec / step #integer division
    partial_step_dur = sec % step
    puts "#{partial_step_dur} < #{@duration} ? #{partial_step_dur < @duration}"
    
    partial_step_dist = partial_step_dur < @duration ? partial_step_dur * @speed : @duration * @speed

    dist = num_steps * @speed + partial_step_dist 
    puts "#{dist} = #{num_steps} * #{@speed} + #{partial_step_dist}" 
    dist
  end
end

class Games
  attr_reader :input
  
  def initialize()
  end

  def step(instruction)
    
  end

  def calc()
  end

end

class Day14
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()

    @input.each_line do |line|
      #do something with each line
    end


  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day14.input.txt'
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
  
  ans = Day14.new(input)
  ans.calc()

end
