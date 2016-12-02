load 'Day9.rb'

describe Inst do
  it "should pull out the first location" do
    inst = Inst.new('London to Dublin = 464')
    expect(inst.first).to eq('London')
  end
  it "should pull out the second location" do
    inst = Inst.new('London to Dublin = 464')
    expect(inst.second).to eq('Dublin')
  end
  it "should pull out the distance between locations" do
    inst = Inst.new('London to Dublin = 464')
    expect(inst.dist).to eq(464)
  end
  it "should pull out the locations as an array" do
    inst = Inst.new('London to Dublin = 464')
    expect(inst.loc_array).to eq(['London', '->', 'Dublin'])
  end
end

describe Graph do
  it "should create two entries for each pair" do
    # I don't know how to test this unless I expose the 'loc' lookup
  end
end
