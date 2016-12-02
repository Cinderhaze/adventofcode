#!/usr/bin/env ruby

require 'getoptlong'
require 'digest'

class Day4
  attr_reader :input
  
  def initialize(input)
    @input = input
  end

  def calc()
    answer = 0

    digest = ''

    until digest.start_with?('000000')
      
      answer += 1
      digest = Digest::MD5.hexdigest(input.to_s + answer.to_s )

    end

    puts "secret key: #{input}"
    puts "answer: #{answer}"
    puts "digest: #{digest}"
  end
 
end

#Actually execute things here.. figure out the best way to do this
if __FILE__ == $0

  opts = GetoptLong.new(
    [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
    [ '--file', '-f', GetoptLong::OPTIONAL_ARGUMENT ],
    [ '--input', '-i', GetoptLong::OPTIONAL_ARGUMENT ],
  )

  input_name = 'day4.input.txt'
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
  
  ans = Day4.new(input)
  ans.calc()

end
