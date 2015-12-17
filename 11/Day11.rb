#!/usr/bin/env ruby

require 'getoptlong'

class PwLetter
  #attr_reader 

  def initialize(input = 'a')
    @valid_letters = [*'a'..'h','j','k', 'm', 'n', *'p'..'z']
    index = @valid_letters.index(input)

    @valid_letters.rotate!(index)

    puts "value #{@valid_letters[0]}"
  end

  def to_s
    "#{@value}"
  end

  def value()
    @valid_letters[0]
  end

  # Returns the 'carry' for addition
  def increment()
    @valid_letters.rotate!

    if @valid_letters[0] == 'a'
     # puts "first char is now a, that means we wrapped around"
      return true
    else
     # puts "no wrap around"
      return false
    end

  end
end


class Pw
  attr_reader :pw
  def initialize(input)
    @input = input
    @pw=parse_str(input)
  end

  def parse_str(input)
    result = []
    input.each_char do |c|
      result << PwLetter.new(c)
    end

    return result 
  end

  def to_s
    str = ''
    @pw.map(&:value).join()
  end
end


class Day11
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()
 
    @input.each_line do |line|
      
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

  input_name = 'day11.input.txt'
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
  
  ans = Day11.new(input)
  ans.calc()

end
