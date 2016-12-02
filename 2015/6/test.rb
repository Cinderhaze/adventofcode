load 'Day6.rb'

#describe Day6 do
#  it "ugknbfddgicrmopn should be nice" do
#    ans = Day6.new('ugknbfddgicrmopn')  
#    expect(ans.calc()).to equal(1)
#  end
#end

describe Light do
  it "should initially be not on" do
    light = Light.new()  
    expect(light.on?()).to equal(false)
  end
  it "should initially switch on with on()" do
    light = Light.new()  
    light.on()
    expect(light.on?()).to equal(true)
  end
  it "should initially switch off with off()" do
    light = Light.new()  
    light.off()
    expect(light.on?()).to equal(false)
  end
  it "should initially switch on from off with toggle(), and then back to off" do
    light = Light.new()  
    expect(light.on?()).to equal(false)
    light.toggle()
    expect(light.on?()).to equal(true)
    light.toggle()
    expect(light.on?()).to equal(false)
  end
  it "should turn on, then get toggle'd to off" do
    light = Light.new()  
    light.on()
    expect(light.on?()).to equal(true)
    light.toggle()
    expect(light.on?()).to equal(false)
  end
end


describe Inst do
  it "should turn an 'off' instruction into a command" do
    inst = Inst.new('turn off 0,0 through 999,999')
    expect(inst.cmd).to eq('turn off')
  end
  it "should turn a 'toggle' instruction into a command" do
    inst = Inst.new('toggle 0,0 through 999,999')
    expect(inst.cmd).to eq('toggle')
  end
  it "should turn an 'on' instruction into a command" do
    inst = Inst.new('turn on 0,0 through 999,999')
    expect(inst.cmd).to eq('turn on')
  end
  it "should turn an instruction into a start pair" do
    inst = Inst.new('turn on 0,0 through 999,999')
    expect(inst.begin.class).to eq(Pair)
  end
  it "should turn an instruction into an end pair" do
    inst = Inst.new('turn on 0,0 through 999,999')
    expect(inst.end.class).to eq(Pair)
  end
  it "should turn an instruction into a start pair with correct values" do
    inst = Inst.new('turn on 0,0 through 999,999')
    expect(inst.begin.x).to eq(0)
    expect(inst.begin.y).to eq(0)
  end
  it "should turn an instruction into an end pair with correct values" do
    inst = Inst.new('turn on 0,0 through 999,999')
    expect(inst.end.x).to eq(999)
    expect(inst.end.y).to eq(999)
  end
end

describe Grid do
  it "should initialize to having no lights lit" do
    grid = Grid.new()
    expect(grid.num_on()).to equal(0)
  end
  it "should toggle on two light and have two lit" do
    grid = Grid.new()
    grid.step('toggle 0,0 through 0,1')
    expect(grid.num_on()).to equal(2)
  end
  it "should turn on two light and have two lit" do
    grid = Grid.new()
    grid.step('turn on 0,0 through 0,1')
    expect(grid.num_on()).to equal(2)
  end
  it "should turn off a light and have none lit" do
    grid = Grid.new()
    grid.step('turn off 0,0 through 0,1')
    expect(grid.num_on()).to equal(0)
  end
end
