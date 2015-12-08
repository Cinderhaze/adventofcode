load 'Day6.rb'

describe Day6 do
  it "ugknbfddgicrmopn should be nice" do
    ans = Day6.new('ugknbfddgicrmopn')  
    expect(ans.calc()).to equal(1)
  end
end
