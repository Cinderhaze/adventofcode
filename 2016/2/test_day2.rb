require 'minitest/autorun'
require_relative './Day2.rb'

class TestNumberpad < Minitest::Test
  SHORT = ["UUUDDDUUU", "LLLRRRLLL", "RUDL", "LDUR"]
  LONG  = File.read("./input.txt").split("\n")

  def setup
      @Numberpad = Numberpad.new(SHORT)
  end

end
