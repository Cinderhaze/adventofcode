#!/usr/bin/env ruby

require 'getoptlong'

class Inst
  attr_reader :cmd, :result, :operands, :shift

  def initialize(inst)
    @operands= Array.new
    @solved = false
    parseInst(inst)
  end

  def parseInst(inst)
    #use a regex to create three matchgrups
    case inst
    when /(.*) (OR|AND) (.*) -> (.*)/
      @operands << $1
      @operands << $3
      @cmd = $2
      @result = $4
    when /(.*) ([L|R]SHIFT) (.*) -> (.*)/
      @operands << $1
      @shift = $3.to_i
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
    if instruction.class == String
      inst = Inst.new(instruction)
    elsif instruction.class == Inst
      inst = instruction
    else
      puts " WHOOP WHOOP WHOOP I don't know how to handle #{instruction.class}"
    end
    case inst.cmd
      when 'SIG'
        @results[inst.result] = inst.operands[0].to_i
      when 'OR'
        if @results.key? inst.operands[0] and @results.key? inst.operands[1]
          puts "#{inst.result} -> #{@results[inst.operands[0]]} | #{@results[inst.operands[1]]}"
          @results[inst.result]= @results[inst.operands[0]] | @results[inst.operands[1]]
        else
          puts 'storing this for later'
          @steps[inst.result]=inst
        end
      when 'AND'
        if @results.key? inst.operands[0] and @results.key? inst.operands[1]
          puts "#{inst.result} -> #{@results[inst.operands[0]]} & #{@results[inst.operands[1]]}"
          @results[inst.result]= @results[inst.operands[0]] & @results[inst.operands[1]]
        else
          puts 'storing this for later'
          @steps[inst.result]=inst
        end
      when 'LSHIFT'
        if @results.key? inst.operands[0]
          puts "#{inst.result} -> #{@results[inst.operands[0]]} << #{inst.shift}"
          @results[inst.result]= @results[inst.operands[0]] << inst.shift
        else
          puts 'storing this for later'
          @steps[inst.result]=inst
        end
      when 'RSHIFT'
        if @results.key? inst.operands[0]
          puts "#{inst.result} -> #{@results[inst.operands[0]]} >> #{inst.shift}"
          @results[inst.result]= @results[inst.operands[0]] >> inst.shift
        else
          puts 'storing this for later'
          @steps[inst.result]=inst
        end
      when 'NOT'
        if @results.key? inst.operands[0]
          puts "#{inst.result} -> 65535 - #{@results[inst.operands[0]]}"
          @results[inst.result]= 65535 - @results[inst.operands[0]].to_i
        else
          puts 'storing this for later'
          @steps[inst.result]=inst
        end
    end

  end

  def calc()
    until @steps.empty?
      #if all arrays are valid keys in @results, process it
      #else, come back to it once you reach the end of the list
      @steps.first
    end
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
