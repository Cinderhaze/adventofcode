#!/usr/bin/env ruby

require 'getoptlong'

class SantaStr
  attr_reader :input
  
  def initialize(input)
    @input = input
#    puts "#{input.chars.to_a}"
#    puts "#{input}"
  end

  def code_count
    input.length
  end

  def mem_count
    /"(?<local>.*)"/ =~ @input

    # this matches (\x## or \\ or \" or any char)
    local.scan(/(\\x\d\d)|(\\[\\|\"])|(.)/).length

 #   eval(@input).length
  end

end

class Day8
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()
 
    code = []
    mem = []
    @input.each_line do |line|
      ss = SantaStr.new(line.chomp)
      code << ss.code_count
      mem << ss.mem_count
      
    end
 
    code_count = code.inject{|x,sum| sum + x}
    mem_count = mem.inject{|x,sum| sum + x}
#    puts code
    puts "Total code chars: #{code_count}"
#    puts mem
    puts "Total in mem chars: #{mem_count}"

    puts "code - mem: #{code_count - mem_count}"

  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day8.input.txt'
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
  
  ans = Day8.new(input)
  ans.calc()

end
