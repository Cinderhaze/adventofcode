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
    count = local.scan(/(\\x\d\d)|(\\[\\|\"])|(.)/).length
#    puts local
#    count
  end

end

class Day8
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()
 
    code = 0
    mem = 0
    @input.each_line do |line|
      ss = SantaStr.new(line)
      code += ss.code_count
      mem += ss.mem_count
      
    end
 
    puts "Total code chars: #{code}"
    puts "Total in mem chars: #{mem}"
    puts "code - mem: #{code - mem}"

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
