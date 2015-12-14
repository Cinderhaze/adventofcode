load 'Day8.rb'

describe SantaStr do
  it '"" is 2 characters of code (the two double quotes)' do
    ss = SantaStr.new('""')
    expect(ss.code_count).to eq(2)
  end
  it '"" contains zero in-mem characters' do
    ss = SantaStr.new('""')
    expect(ss.mem_count).to eq(0)
  end
  it '"abc" is 5 characters of code' do
    ss = SantaStr.new('"abc"')
    expect(ss.code_count).to eq(5)
  end
  it '"abc" is 3 characters in the string data' do
    ss = SantaStr.new('"abc"')
    expect(ss.mem_count).to eq(3)
  end
  it '"aaa\"aaa" is 10 characters of code' do
    ss = SantaStr.new('"aaa\"aaa"')
    expect(ss.code_count).to eq(10)
  end
  it '"aaa\"aaa" itself contains six "a" characters and a single, escaped quote character, for a total of 7 characters in the string data' do
    ss = SantaStr.new('"aaa\"aaa"')
    expect(ss.mem_count).to eq(7)
  end
  it '"aaa\\aaa" itself contains six "a" characters and a single, escaped slash character, for a total of 7 characters in the string data' do
    ss = SantaStr.new('"aaa\\aaa"')
    expect(ss.mem_count).to eq(7)
  end
  it '"\x27" is 6 characters of code' do
    ss = SantaStr.new('"\x27"')
    expect(ss.code_count).to eq(6)
  end
#  it '"\x27" contains just one - an apostrophe (\'), escaped using hexadecimal notation.' do
#    ss = SantaStr.new('"\x27"')
#    expect(ss.mem_count).to eq(1)
#  end
end

#describe Day8 do
#  it "given the four strings above, the total number of characters of string code (2 + 5 + 10 + 6 = 23) minus the total number of characters in memory for string values (0 + 3 + 7 + 1 = 11) is 23 - 11 = 12" do
#end
