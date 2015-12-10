load 'Day10.rb'

describe LookAndSay do
  it "1 becomes 11 (1 copy of digit 1)" do
    ls = LookAndSay.new('1')
    expect(ls.result).to eq('11')
  end
  it "11 becomes 21 (2 copies of digit 1)" do
    ls = LookAndSay.new('11')
    expect(ls.result).to eq('21')
  end
  it "21 becomes 1211 (one 2 followed by one 1)" do
    ls = LookAndSay.new('21')
    expect(ls.result).to eq('1211')
  end
  it "1211 becomes 111221 (one 1, one 2, and two 1s)" do
    ls = LookAndSay.new('1211')
    expect(ls.result).to eq('111221')
  end
  it "111221 becomes 312211 (three 1s, two 2s, and one 1)" do
    ls = LookAndSay.new('111221')
    expect(ls.result).to eq('312211')
  end
end

# figure out a way to test the above as doing 5 iteations of '1'
describe Day10 do
  it "Should loop once by default" do
    ans = Day10.new('1')
    expect(ans.calc()).to eq('11')
  end
  it "Should loop twice and get 21" do
    ans = Day10.new('1')
    expect(ans.calc(2)).to eq('21')
  end
  it "Should loop five times and get 312211" do
    ans = Day10.new('1')
    expect(ans.calc(5)).to eq('312211')
  end
end

