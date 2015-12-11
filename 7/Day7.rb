#!/usr/bin/env ruby

require 'getoptlong'

class Inst
  attr_reader :cmd, :result, :operands

  def initialize(inst)
    @operands= Array.new
    parseInst(inst)
  end

  def parseInst(inst)
    #use a regex to create three matchgrups
    case inst
    when /(.*) (OR|AND|[L|R]SHIFT) (.*) -> (.*)/
      @operands << $1
      @operands << $3
      @cmd = $2
      @result = $4
    when /NOT (.*) -> (.*)/
      @operands << $1
      @cmd = 'NOT'
      @result = $2
    when /(\d*) -> (.*)/
      @operands << $1
      @cmd = 'SIG'
      @result = $2
    end
  end
end

class Circuit
  attr_reader :input, :results
  
  def initialize()
    @results = Hash.new
    @steps = Array.new
    
  end

  def step(instruction)
    steps << Inst.new(instruction)
  end

  def calc()
    #Take each 'result' value from the instructions and iterativly/recursivly look up their values
  end

end

class Day7
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()

    circuit = Circuit.new()
    @input.each_line do |line|
      circuit.step(line)
    end

    circuit.calc()

    puts circuit.results

  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day7.input.txt'
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
  
  ans = Day7.new(input)
  ans.calc()

end
