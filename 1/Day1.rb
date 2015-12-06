#!/usr/bin/env ruby

class Day1
  attr_reader :input, :floor, :in_basement
  
  def initialize(input)
    @input = input
    @floor = 0
    @in_basement = Array.new
  end
 
  def path()
    count = 1
    @input.each_char { |c|
      case c
       when '(' then @floor +=1
       when ')' then @floor -=1
      end
      if @floor == -1
        @in_basement << count
      end
      count += 1
    }
    @floor
  end
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  input_name = 'day1.input.txt'
  input = IO.read(input_name)

  ans = Day1.new(input)
  ans.path()
  puts "Floor #{ans.floor}"
  puts "First entrance to basement #{ans.in_basement.first}"

end
