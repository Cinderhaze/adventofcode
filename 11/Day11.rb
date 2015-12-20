#!/usr/bin/env ruby

require 'getoptlong'

class Pw
  attr_reader :pw
  def initialize(input)
    @pw = input.to_s
  end

  def to_s
    @pw
  end

  def valid?()
    #contains straight of three letters
    #does not contain i,o,l (taken care of in the letter type)
    #must contain two different, non-overlapping pairs of letters
    self.straight? and self.pairs?
  end

  def straight?
    @pw.split('').each_cons(3).any? { |a,b,c| [a,a.next,a.next.next] == [a,b,c] }
  end

  def pairs?
    # Not sure why this one fails with two like pairs
    #pairs = /(.)\1.*([^\1])\2/ =~ self.to_s
    #!!pairs
    num_pairs = @pw.split('').each_cons(2).to_a.uniq.count {|pair| pair[0] == pair[1] } #Solution from jesus_castello on CodeNewbie chat.. I think I would prefer to map over each_cons and return the letter/pair, and then uniq and count... not sure
    num_pairs >= 2
  end

  def valid_letters?
    #todo look for i,o,l
  end

  #increment until valid
  def increment()
     puts "Inc start: #{self.to_s}"
     inc_unchecked()
  end
  
  #increment, but don't validate
  def inc_unchecked()
     puts "Inc unchecked: #{self.to_s}"
     @pw.next!
      
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
