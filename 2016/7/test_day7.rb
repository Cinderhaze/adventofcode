
require 'minitest/autorun'
require_relative './Day7.rb'

class TestNumberpad < Minitest::Test
  def test_ABBA_before_brackets_supports_TLS
      input = 'abba[mnop]qrst'
      ipv7 = Ipv7.new(input)
      actual_value = ipv7.supportsTls
      assert(actual_value)
  end

  def test_ABBA_from_str
      input = 'abba[mnop]qrst'
      ipv7 = Ipv7.new(input)
      actual_value = ipv7.abba(input)
      expected_value = ['abba']
      assert_equal(expected_value,actual_value)
     
  end

  #abba[mnop]qrst supports TLS (abba outside square brackets).
  #abcd[bddb]xyyx does not support TLS (bddb is within square brackets, even though xyyx is outside square brackets).
  #aaaa[qwer]tyui does not support TLS (aaaa is invalid; the interior characters must be different).
  #ioxxoj[asdfgh]zxcvbn supports TLS (oxxo is outside square brackets, even though it's within a larger string).
end