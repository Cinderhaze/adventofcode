#!/usr/bin/env ruby

require 'getoptlong'

def nice?(input)
end

class Day5
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()

    count = 0;
    total = 0;
    @input.each_line do |line|
      count +=1 if nice?(line)
      total +=1
    end

    puts "#{count} nice strings out of #{total}"

  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day5.input.txt'
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
  
  ans = Day5.new(input)
  ans.calc()

end
