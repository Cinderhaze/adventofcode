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
end

describe Graph do
end
