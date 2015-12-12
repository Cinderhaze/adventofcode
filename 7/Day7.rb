#!/usr/bin/env ruby

require 'getoptlong'

class Inst
  attr_reader :cmd, :result, :operands, :solved

  def initialize(inst)
    @operands= Array.new
    @solved = false
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
      @solved = true
    end
  end
  def solve()
    
  end
  def solved?()
    @solved
  end
end

class Circuit
  attr_reader :input, :results
  
  def initialize()
    @results = Hash.new
    @steps = Hash.new
    
  end

  #assume that you can just solve each instruction as you get it, and you don't need to build a graph and iterativly sovlve it
  def step(instruction)
    inst = Inst.new(instruction)
    case inst.cmd
      when 'SIG'
        @results[inst.result] = inst.operands[0].to_i
      when 'OR'
        puts "#{inst.result} -> #{@results[inst.operands[0]]} | #{@results[inst.operands[1]]}"
        @results[inst.result]= @results[inst.operands[0]] | @results[inst.operands[1]]
      when 'AND'
        puts "#{inst.result} -> #{@results[inst.operands[0]]} & #{@results[inst.operands[1]]}"
        @results[inst.result]= @results[inst.operands[0]] & @results[inst.operands[1]]
      when 'LSHIFT'
        puts "#{inst.result} -> #{@results[inst.operands[0]]} << #{inst.operands[1]}"
        @results[inst.result]= @results[inst.operands[0]] << inst.operands[1].to_i
      when 'RSHIFT'
        puts "#{inst.result} -> #{@results[inst.operands[0]]} >> #{inst.operands[1]}"
        @results[inst.result]= @results[inst.operands[0]] >> inst.operands[1].to_i
      when 'NOT'
        puts "#{inst.result} -> 65535 - #{@results[inst.operands[0]]}"
        @results[inst.result]= 65535 - @results[inst.operands[0]].to_i
    end

    puts @results
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
