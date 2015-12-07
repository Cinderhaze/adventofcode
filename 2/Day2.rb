#!/usr/bin/env ruby

require 'getoptlong'

class Side
  attr_reader :area, :perimeter

  def initialize(edge1, edge2)
    @edges = [ edge1.to_i, edge2.to_i ]
    calcPerimeter(edge1, edge2)
    calcArea(edge1, edge2)
  end

  def calcPerimeter(edge1, edge2)
    @perimeter = 2 * edge1.to_i + 2 * edge2.to_i
  end

  def calcArea(edge1, edge2)
    @area = edge1.to_i * edge2.to_i 
  end

  def to_s
    puts "Edges: #{@edges}, Area: #{@area}, Perimeter: #{@perimeter}"
  end

end

class Box
  attr_reader :area, :extra, :total, :edges, :sides, :ribbon, :bow, :volume
  

  def initialize(input)
    @area = 0
    @extra = 0
    @total = 0
    @edges = {} 
    @sides = []
    @ribbon = 0
    @bow = 0

    temp = input.split('x')
    @edges[:l] = temp.shift.to_i
    @edges[:w] = temp.shift.to_i
    @edges[:h] = temp.shift.to_i
  end

  def calcArea()
    #populate half the sides
    @sides << Side.new(@edges[:l], @edges[:w])
    @sides << Side.new(@edges[:w], @edges[:h])
    @sides << Side.new(@edges[:h], @edges[:l])

    puts @sides

    @extra = @sides.sort{|l,r| l.area <=> r.area}.first.area

    @sides.each do |side|
        @area += 2 * side.area.to_i
    end

    @total = @area + @extra
 
    smallest_side_perim =@sides.sort{|l,r| l.perimeter <=> r.perimeter}.first.perimeter 
    @ribbon = smallest_side_perim
    
    @area
  end

  def calcVolume()
    @volume = @edges.values.reduce(:*) 
    @volume
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
    wrapping = 0
    bow = 0
    @input.each_line do |line|
      puts "--#{line.chomp}--"
      box = Box.new(line.chomp)
      box.calcArea()
      box.calcVolume()
      puts "Box area: #{box.area}"
      puts "Box extra area: #{box.extra}"
      puts "Box total area: #{box.total}"

      extra += box.extra
      total += box.total

      puts "Box volume area: #{box.volume}"
      puts "Box ribbon length: #{box.ribbon}"

      wrapping += box.ribbon 
      bow += box.volume 
      
    end

    puts
    puts "Total Required wrapping paper: #{total} sq ft"
    puts "Total Required extra wrapping paper: #{extra} sq ft"

    puts "Wrapping ribbon: #{wrapping}"
    puts "Bow ribbon: #{bow}"
    puts "Total ribbon: #{wrapping + bow}"
  end
 
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
