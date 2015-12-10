#!/usr/bin/env ruby

require 'getoptlong'
require 'set'

class LookAndSay
  attr_reader :result

  def initialize(input)
    @input = input
    parse(input)
  end

  def parse(input)
    new_seq = []
    last_char = input[0]
    count = 0
    #start with the first char
    input.each_char do |c|
      #count how many times that char appears till newChar/end of line
      if c == last_char 
        #accumulate
        count += 1
      else 
        #store off old values, and reset accumulators
        new_seq << count
        new_seq << last_char
        # first of new char
        count = 1
        last_char = c
      end
      #on transition, store count follwed by number
    end
    # after loop
    #store off final accumulator values
    new_seq << count
    new_seq << last_char

    # accumulated numbers is the new string
    @result=new_seq.join
  end
  
end

class Day10
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc(loops=1)
    ls = nil
    @input.each_line do |line|
      ls = LookAndSay.new(line)
      (loops-1).times do
        ls = LookAndSay.new(ls.result)
      end
    end
    ls.result
  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--number', '-n', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day10.input.txt'
  input = nil
  num=1
  
  opts.each do |opt, arg|
    case opt
      when '--file'
        input_name = arg.to_s
      when '--input'
        input = arg.to_s
      when '--number'
        num = arg.to_i
    end
  end

  if !input 
    input = IO.read(input_name)
  end
  
  ans = Day10.new(input)
  length = ans.calc(num).length
  puts "Length of result is #{length}"

end
