load 'Day7.rb'

describe Inst do
  it "means that the signal 123 is provided to wire x" do
    inst = Inst.new('123 -> x')
    expect(inst.result).to eq('x')
    expect(inst.cmd).to eq('SIG')
    expect(inst.operands).to eq(['123'])
  end
  it "means that the bitwise AND of wire x and wire y" do
    inst = Inst.new('x AND y -> z')
    expect(inst.result).to eq('z')
    expect(inst.cmd).to eq('AND')
    expect(inst.operands).to eq(['x','y'])
  end
  it "means that the bitwise OR of wire x and wire y" do
    inst = Inst.new('x OR y -> z')
    expect(inst.result).to eq('z')
    expect(inst.cmd).to eq('OR')
    expect(inst.operands).to eq(['x','y'])
  end
  it "means that the value from wire p is left-shifted by 2 and then provided to wire q" do
    inst = Inst.new('p LSHIFT 2 -> q')
    expect(inst.result).to eq('q')
    expect(inst.cmd).to eq('LSHIFT')
    expect(inst.operands).to eq(['p','2'])
  end
  it "means that the value from wire p is right-shifted by 2 and then provided to wire q" do
    inst = Inst.new('p RSHIFT 2 -> q')
    expect(inst.result).to eq('q')
    expect(inst.cmd).to eq('RSHIFT')
    expect(inst.operands).to eq(['p','2'])
  end
  it "means that the bitwise complement of the value from wire e is provided to wire f" do
    inst = Inst.new('NOT e -> f')
    expect(inst.result).to eq('f')
    expect(inst.cmd).to eq('NOT')
    expect(inst.operands).to eq(['e'])
  end
end

describe Circuit do
#  it "should initialize to having no lights lit" do
#    grid = Grid.new()
#    expect(grid.num_on()).to equal(0)
#  end
end
