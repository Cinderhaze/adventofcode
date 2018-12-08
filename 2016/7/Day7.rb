class Ipv7
  attr_reader :input, :pre, :hypernet, :post

#  PATTERN = /^([^\[]*)\[(.*)\](.*)$/
  PATTERN = /(?<outer>(?<inner>[^\[^\]\]]*)(?<hyper>\[[^\[\]]*\])?)/
  
  def initialize(input)
    @input = input
    @partitoned = partitionInput(input)
    p @partitioned
  end

  def partitionInput(input)
    holderArry = []
    input.scan(PATTERN){|outer, inner, hyper| holderArry << [inner, hyper]}
    holderArry
  end

  # Returns an array of 4 letter palindromes in the given string
  def abba(str)
    str.chars.each_cons(4)
      .select{|word| word == word.reverse and word[0] != word[1]}
      .map(&:join)
  end

  def supportsTls
    # does not have abba within hypernet
    # AND
    # has abba outside of hypernet
    #abba(@hypernet).empty? and (! abba(@pre).empty? or ! abba(@post).empty?)
  end

end

class Day7
  attr_reader :input
  def initialize(input)
    @input = input
  end

  def count_tls_supporters
    supports = 0
    @input.each_line do |line|
      ipv7 = Ipv7.new(line)
      supports += 1 if ipv7.supportsTls
    end
    supports
  end

  def supports
    count_tls_supporters
  end

  
end