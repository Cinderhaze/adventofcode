load 'Day5.rb'

describe Day5 do
  it "ugknbfddgicrmopn should be nice" do
    ans = Day5.new('ugknbfddgicrmopn')  
    expect(ans.calc()).to equal(1)
  end
  it "aaa should be nice" do
    ans = Day5.new('aaa')  
    expect(ans.calc()).to equal(1)
  end
  it "jchzalrnumimnmhp should be naughty due to no doubles" do
    ans = Day5.new('jchzalrnumimnmhp')  
    expect(ans.calc()).to equal(0)
  end
  it "haegwjzuvuyypxyu should be naughty due to xy " do
    ans = Day5.new('haegwjzuvuyypxyu')  
    expect(ans.calc()).to equal(0)
  end
  it "dvszwmarrgswjxmb should be naughty due to only one vowel" do
    ans = Day5.new('dvszwmarrgswjxmb')  
    expect(ans.calc()).to equal(0)
  end
end
