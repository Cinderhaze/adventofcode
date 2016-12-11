class Ipv7
  attr_reader :input, :pre, :hypernet, :post

  PATTERN = /([^\[]*)\[(.*)\](.*)/
  
  def initialize(input)
    @input = input
    PATTERN =~ input
    @pre, @hypernet, @post = $1, $2, $3
  end

  # Returns an array of 4 letter palindromes in the given string
  def abba(str)
    str.chars.each_cons(4).select{|word| word == word.reverse}.map{|ary| ary.join}
  end

  def supportsTls
    # has abba outside of hypernet
    p abba(@pre)
    p abba(@post)
    # also does not have abba within hypernet
  end

end