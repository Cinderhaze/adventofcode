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


describe Light do
  it "should turn an instruction into a command" do
    inst = Inst.new('turn on 0,0 through 999,999')
    expect(inst.cmd).to eq('turn on')
  end
  it "should turn an instruction into a start range" do
    inst = Inst.new('turn on 0,0 through 999,999')
    expect(inst.begin).to eq('0,0')
  end
  it "should turn an instruction into an end range" do
    inst = Inst.new('turn on 0,0 through 999,999')
    expect(inst.end).to eq('999,999')
  end
end
