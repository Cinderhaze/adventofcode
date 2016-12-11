
require 'minitest/autorun'
require_relative './Day7.rb'

class TestNumberpad < Minitest::Test
  #abba[mnop]qrst supports TLS (abba outside square brackets).
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

  #abcd[bddb]xyyx does not support TLS (bddb is within square brackets, even though xyyx is outside square brackets).
  def test_ABBA_within_brackets_does_not_supports_TLS
      input = 'abcd[bddb]xyyx'
      ipv7 = Ipv7.new(input)
      actual_value = ipv7.supportsTls
      assert( !actual_value)
  end
  #aaaa[qwer]tyui does not support TLS (aaaa is invalid; the interior characters must be different).
  def test_ABBA_interior_chars_must_be_diff_not_supports_TLS
      input = 'aaaa[qwer]tyui'
      ipv7 = Ipv7.new(input)
      actual_value = ipv7.supportsTls
      assert(! actual_value)
  end
  #ioxxoj[asdfgh]zxcvbn supports TLS (oxxo is outside square brackets, even though it's within a larger string).
  def test_ABBA_within_larger_string_supports_TLS
      input = 'ioxxoj[asdfgh]zxcvbn'
      ipv7 = Ipv7.new(input)
      actual_value = ipv7.supportsTls
      assert(actual_value)
  end

  def test_count_ips_that_support_tls
    #1&4 support, 2&3 do not
    input = <<-EOF
abba[mnop]qrst
abcd[bddb]xyyx
aaaa[qwer]tyui
ioxxoj[asdfgh]zxcvbn
    EOF
    day7 = Day7.new(input)
    actual = day7.supports
    assert_equal(2, actual)

  end
end