#!/usr/bin/env ruby

require 'getoptlong'
require 'json'

#Shamelessly pulled from http://stackoverflow.com/questions/10712679/flatten-a-nested-json-object
# doesn't properly handle multiply nested arrays
module Enumerable
  def flatten_with_path(parent_prefix = nil)
    res = {}

    self.each_with_index do |elem, i|
      if elem.is_a?(Array)
        k, v = i, elem.flatten
      else
        k, v = i, elem
      end

      key = parent_prefix ? "#{parent_prefix}.#{k}" : k # assign key name for result hash

      if v.is_a? Enumerable
        res.merge!(v.flatten_with_path(key)) # recursive call to flatten child elements
      else
        res[key] = v
      end
    end

    res
  end
end

class Counter
  attr_reader :json
  def initialize(input)
    @json = JSON.parse(input)
  end

  def total
#    puts @json
#    puts @json.flatten_with_path.inspect
#    @json.flatten_with_path.values.each {|x| puts "#{x}:#{x.class}"}
    @json.flatten_with_path.values.select{|x| x.class == Fixnum}.inject(0) {|x, sum| sum + x}
  end
end


class Day12
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()
 
    @input.each_line do |line|
      c = Counter.new(line)
      
      puts "Total: #{c.total}"
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

  input_name = 'day12.input.txt'
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
  
  ans = Day12.new(input)
  ans.calc()

end
