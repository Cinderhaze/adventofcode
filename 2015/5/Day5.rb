#!/usr/bin/env ruby

require 'getoptlong'

def nice?(input)
  # any three vowels
  three_vowels =/(.*[aeiou].*){3,}/
  repeated_letter = /(.)\1/
  bad_groups = /(ab|cd|pq|xy)/

  pass = true
  
#  puts "Testing: #{input}"
  if three_vowels =~ input
  else
#    puts 'FAIL three vowels'
    pass &= false
  end
  if repeated_letter =~ input
  else
#    puts 'FAIL repeated letter'
    pass &= false
  end
  if bad_groups =~ input
#    puts 'FAIL no bad groups'
    pass &= false
  end
  
  !!pass
  
end

def nice_now?(input)
  two_letter_repeat = /(.)(.).*\1\2/
  letter_sandwich = /(.).\1/

  pass=true

  if two_letter_repeat =~ input
  else
    puts 'FAIL two letter repeat'
    pass &= false
  end

  if letter_sandwich =~ input
  else
    puts 'FAIL letter sandwich'
    pass &= false
  end
  !! pass
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
#      count +=1 if nice?(line)
      count +=1 if nice_now?(line)
      total +=1
    end

    puts "#{count} nice strings out of #{total}"
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
