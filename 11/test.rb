load 'Day11.rb'

describe Pw do
  it "should initialize to 'abc'" do
    pw = Pw.new('abc')
    expect(pw.to_s).to eq('abc')
  end
  it "should check to see if it's invalid - straight of at least three letters" do
    pw = Pw.new('aaa')
    expect(pw.straight?).to eq(false)
  end
  it "should check to see if it's valid - straight of at least three letters" do
    pw = Pw.new('abc')
    expect(pw.straight?).to eq(true)
  end
  it "should check to see if it's a pair - contain two different, non-overlapping pairs of letters" do
    pw = Pw.new('aabbcd')
    expect(pw.pairs?).to eq(true)
  end
  it "should check to see if it's not a pair - only contain one of two different, non-overlapping pairs of letters" do
    pw = Pw.new('aaaabc')
    expect(pw.pairs?).to eq(false)
  end
  it "should check to see if it's invalid - only contain one of two different, non-overlapping pairs of letters" do
    pw = Pw.new('aaaabc')
    expect(pw.pairs?).to eq(false)
  end
#  it "should increment from abcdefgh to abcdffaa" do
#    pw = Pw.new('abcdefgh')
#    pw.increment()
#    expect(pw.to_s).to eq('abcdffaa')
#  end
#  it "should increment from ghijklmn is ghjaabcc, because you eventually skip all the passwords that start with ghi..., since i is not allowed" do
#    pw = Pw.new('ghijklmn ')
#    expect(pw.to_s).to eq('ghjaabcc')
#  end
end

#describe Day11 do
#end
