#!/usr/bin/env ruby

require 'getoptlong'
require 'pp'


class Day1
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()
    tc = nil
    @input.each_line do |line|
      tc = Taxicab.new(line)
    end
    tc
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

  input_name = 'input.txt'
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
  
  ans = Day1.new(input)
  res = ans.calc()
  puts "Distance traveled is #{res.distance}"
  puts "Intersection point at #{res.track_path}"

end
