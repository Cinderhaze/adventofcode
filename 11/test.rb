load 'Day11.rb'

describe PwLetter do
  it "should have the value 'a' when init with no args" do
    l = PwLetter.new
    expect(l.value).to eq('a')
  end
  it "should increment from 'a' to 'b'" do
    l = PwLetter.new
    carry = l.increment()
    expect(l.value).to eq('b')
  end
  it "should increment from 'a' to 'b' with no carryover bit" do
    l = PwLetter.new
    carry = l.increment()
    expect(carry).to eq(false)
    expect(l.value).to eq('b')
  end
  it "should init to z when passed z" do
    l = PwLetter.new('z')
    expect(l.value).to eq('z')
  end
  it "should increment from 'z' to 'a' with carryover bit" do
    l = PwLetter.new('z')
    carry = l.increment()
    expect(carry).to eq(true)
    expect(l.value).to eq('a')
  end
  it "should increment from 'h' to 'j', skipping i" do
    l = PwLetter.new('h')
    carry = l.increment()
    expect(l.value).to eq('j')
  end
  it "should increment from 'k' to 'm', skipping l" do
    l = PwLetter.new('k')
    carry = l.increment()
    expect(l.value).to eq('m')
  end
  it "should increment from 'n' to 'p', skipping o" do
    l = PwLetter.new('n')
    carry = l.increment()
    expect(l.value).to eq('p')
  end
end

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
  it "should check to see if it's valid - contain two different, non-overlapping pairs of letters" do
    pw = Pw.new('aabbcd')
    expect(pw.pairs?).to eq(true)
  end
  it "should check to see if it's invalid - only contain one of two different, non-overlapping pairs of letters" do
    pw = Pw.new('aaaabc')
    expect(pw.pairs?).to eq(false)
  end
#  it "should increment from abcdefgh to abcdffaa" do
#    pw = Pw.new('abcdefgh')
#    expect(pw.to_s).to eq('abcdffaa')
#  end
#  it "should increment from ghijklmn is ghjaabcc, because you eventually skip all the passwords that start with ghi..., since i is not allowed" do
#    pw = Pw.new('ghijklmn ')
#    expect(pw.to_s).to eq('ghjaabcc')
#  end
end

#describe Day11 do
#end
