#!/usr/bin/env ruby

require 'getoptlong'

class Box
  attr_reader :area, :extra, :total, :edges, :sides

  def initialize(input)
    @area = 0
    @extra = 0
    @total = 0
    @edges = {} 
    @sides = []

    temp = input.split('x')
    @edges[:l] = temp.shift.to_i
    @edges[:w] = temp.shift.to_i
    @edges[:h] = temp.shift.to_i
  end

  def calcArea()
    #populate half the sides
    @sides << @edges[:l] * @edges[:w]
    @sides << @edges[:w] * @edges[:h]
    @sides << @edges[:h] * @edges[:l]
    
    @extra = @sides.sort.first

    @sides.each do |side|
        @area += 2 * side
    end

    @total = @area + @extra
    
    @area
  end

  def to_s 
      puts "Box sides: #{@sides}"
      puts "Box area: #{@area}"
      puts "Box extra area: #{@extra}"
      puts "Box total area: #{@total}"
  end

end

class Day2
  attr_reader :input, :sq_ft
  
  def initialize(input)
    @input = input
    @sq_ft = 0
  end

  def calc()
    total = 0
    extra = 0
    @input.each_line do |line|
      puts "--#{line.chomp}--"
      box = Box.new(line.chomp)
#      puts box.to_s
      box.calcArea()
      puts "Box area: #{box.area}"
      puts "Box extra area: #{box.extra}"
      puts "Box total area: #{box.total}"

      extra += box.extra
      total += box.total
      
    end

    puts
    puts "Total Required wrapping paper: #{total} sq ft"
    puts "Total Required extra wrapping paper: #{extra} sq ft"
  end
 
#  def path()
#    @input.each_char { |c|
#      case c
#       when '(' then @floor +=1
#       when ')' then @floor -=1
#      end
#      if @floor == -1
#        @in_basement << count
#      end
#      count += 1
#    }
#    @floor
#  end
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day2.input.txt'
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
  
  ans = Day2.new(input)
  ans.calc()

end
