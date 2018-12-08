require 'minitest/autorun'
require_relative './Day2.rb'

class TestNumberpad < Minitest::Test
  SHORT = ["UUUDDDUUU", "LLLRRRLLL", "RUDL", "LDUR"]
  LONG  = File.read("./2/input.txt").split("\n")

  def setup
      @Numberpad = Numberpad.new(5)
  end
  def test_that_pad_calculates_a_result
    assert_not_nil(@Numberpad.result)
  end
end
