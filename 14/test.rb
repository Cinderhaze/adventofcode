load 'Day14.rb'

comet_inst = 'Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.'
dancer_inst = 'Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.'

describe Inst do
  it "Should name commet" do
    inst = Inst.new(comet_inst)
    expect(inst.name).to eq('Comet')
  end
  it "Should have speed 14" do
    inst = Inst.new(comet_inst)
    expect(inst.speed).to eq(14)
  end
  it "Should have duration 10" do
    inst = Inst.new(comet_inst)
    expect(inst.duration).to eq(10)
  end
  it "Should rest for 127" do
    inst = Inst.new(comet_inst)
    expect(inst.rest).to eq(127)
  end
end

describe Reindeer do
  it "Dancer should be at 16 km @1 sec" do
    comet = Reindeer.new(dancer_inst)
    expect(comet.loc(1)).to eq(16)
  end
  it "Comet should be at 14 km @1 sec" do
    comet = Reindeer.new(comet_inst)
    expect(comet.loc(1)).to eq(14)
  end
  it "Dancer should be at 160 km @10 sec" do
    comet = Reindeer.new(dancer_inst)
    expect(comet.loc(10)).to eq(160)
  end
  it "Comet should be at 140 km @10 sec" do
    comet = Reindeer.new(comet_inst)
    expect(comet.loc(10)).to eq(140)
  end
  it "Dancer should be at 176 km @11 sec" do
    comet = Reindeer.new(dancer_inst)
    expect(comet.loc(11)).to eq(176)
  end
  it "Comet should be at 140 km @11 sec" do
    comet = Reindeer.new(comet_inst)
    expect(comet.loc(11)).to eq(140)
  end
  it "Comet should be at 140 km @136 sec (end of first step)" do
    comet = Reindeer.new(comet_inst)
    expect(comet.loc(136)).to eq(140)
  end
  it "Comet should be at 140 km @137 sec (end of first step)" do
    comet = Reindeer.new(comet_inst)
    expect(comet.loc(137)).to eq(140)
  end
  #after first 'step'
  it "Comet should be at 154 km @138 sec (beginning of second step)" do
    comet = Reindeer.new(comet_inst)
    expect(comet.loc(138)).to eq(140+14)
  end
  
#  it "Dancer should be at 1056 km @1000 sec" do
#    comet = Reindeer.new(dancer_inst)
#    expect(comet.loc(1000)).to eq(1056)
#  end
#  it "Comet should be at 1120 km @1000 sec" do
#    comet = Reindeer.new(comet_inst)
#    expect(comet.loc(1000)).to eq(1120)
#  end
end
