#!/usr/bin/env ruby

require 'getoptlong'

class Inst
  attr_reader :inst, :cmd, :result, :operands, :shift

  def initialize(inst)
    @inst = inst
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
    when /(.*) -> (.*)/
      @operands << $1
      @cmd = 'SIG'
      @result = $2
    end
  end
  def to_s
    "result: #{@result}, operands: #{@operands}, shift: #{@shift}, cmd: #{@cmd} ---- #{inst}"
  end
end

class Circuit
  attr_reader :input, :results
  
  def initialize()
    @results = Hash.new
    @steps = Array.new
    
  end

  def prestep(instruction)
    @steps << Inst.new(instruction)
  end
  #assume that you can just solve each instruction as you get it, and you don't need to build a graph and iterativly sovlve it
  def step(instruction)
    if instruction.class == String
      inst = Inst.new(instruction)
    elsif instruction.class == Inst
      inst = instruction
 #     puts "Inst inst"
    else
      puts " WHOOP WHOOP WHOOP I don't know how to handle #{instruction.class}"
    end
 
    puts "In Step for #{inst}"

    case inst.cmd
      when 'SIG'
        if /\d+/ =~ inst.operands[0] 
          puts "MATCHED DIGITS ON SIG"
          @results[inst.result] = inst.operands[0].to_i
        else
          puts "did not MATCH DIGITS ON SIG"
          puts 'storing this for later'
          @steps << inst
        end
      when 'OR'
        lop = nil
        if @results.key? inst.operands[0]
          lop = @results[inst.operands[0]] 
        elsif /\d+/ =~ inst.operands[0]
          lop = inst.operands[0].to_i 
        end

        rop = nil
        if @results.key? inst.operands[1]
          rop = @results[inst.operands[1]] 
        elsif /\d+/ =~ inst.operands[1]
          lop = inst.operands[1].to_i 
        end

        if lop and rop
          puts "#{inst.result} -> #{lop} | #{rop}"
          @results[inst.result]= lop | rop
        else
          puts 'storing this for later'
          @steps << inst
        end
      when 'AND'
        lop = nil
        if @results.key? inst.operands[0]
          lop = @results[inst.operands[0]] 
        elsif /\d+/ =~ inst.operands[0]
          lop = inst.operands[0].to_i 
        end

        rop = nil
        if @results.key? inst.operands[1]
          rop = @results[inst.operands[1]] 
        elsif /\d+/ =~ inst.operands[1]
          lop = inst.operands[1].to_i 
        end

        if lop and rop
          puts "#{inst.result} -> #{lop} & #{rop}"
          @results[inst.result]= lop & rop
        else
          puts 'storing this for later'
          @steps << inst
        end
      when 'LSHIFT'
        if @results.key? inst.operands[0]
          puts "#{inst.result} -> #{@results[inst.operands[0]]} << #{inst.shift}"
          @results[inst.result]= @results[inst.operands[0]] << inst.shift
        else
          puts 'storing this for later'
          @steps << inst
        end
      when 'RSHIFT'
        if @results.key? inst.operands[0]
          puts "#{inst.result} -> #{@results[inst.operands[0]]} >> #{inst.shift}"
          @results[inst.result]= @results[inst.operands[0]] >> inst.shift
        else
          puts 'storing this for later'
          @steps << inst
        end
      when 'NOT'
        if @results.key? inst.operands[0]
          puts "#{inst.result} -> 65535 - #{@results[inst.operands[0]]}"
          @results[inst.result]= 65535 - @results[inst.operands[0]].to_i
        else
          puts 'storing this for later'
          @steps << inst
        end
    end

  end

  def calc()
    puts @results
    puts @steps
    puts "Steps size: #{@steps.size}"

    resultsize = @results.size
    count = 0

    until @steps.empty?  
      if resultsize != @results.size 
        resultsize = @results.size
        puts @results
        puts "Steps size: #{@steps.size}"
        somvar = gets
      end
      if count >= @steps.size 
        puts "-------Looped around-------"
        puts @results
        puts @steps.sort{|a,b| a.result <=> b.result}
        somvar = gets
        count=0
      else
        puts "count: #{count}, steps.size: #{@steps.size}" 
      end
      #if all arrays are valid keys in @results, process it
      #else, come back to it once you reach the end of the list
      inst = @steps.shift
      # step will put it back on the queue if it can't process it
#      puts "Processing #{inst}"
      step(inst)
      count += 1
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
      circuit.prestep(line)
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
