load 'Day12.rb'

describe Counter do
  it "should take in an empty json string and return 0" do
    c = Counter.new('{}')
    expect(c.total).to eq(0)
  end
  it "should return 0 for []" do
    c = Counter.new('[]')
    expect(c.total).to eq(0)
  end
  it "should return 6 for [1,2,3]" do
    c = Counter.new('[1,2,3]')
    expect(c.total).to eq(6)
  end
  it 'should return 6 for {"a":2,"b":4}' do
    c = Counter.new('{"a":2,"b":4}')
    expect(c.total).to eq(6)
  end
  it "should return 3 for [[[3]]]" do
    c = Counter.new('[[[3]]]')
    expect(c.total).to eq(3)
  end
  it 'should return 3 for {"a":{"b":4},"c":-1}' do
    c = Counter.new('{"a":{"b":4},"c":-1}')
    expect(c.total).to eq(3)
  end
  it "should return 0 for {\"a\":[-1,1]}" do
    c = Counter.new('{"a":[-1,1]}')
    expect(c.total).to eq(0)
  end
  it 'should return 0 for [-1,{"a":1}]' do
    c = Counter.new('[-1,{"a":1}]')
    expect(c.total).to eq(0)
  end
  it 'should return 0 for {"d":"red","e":[1,2,3,4],"f":5}' do
    c = Counter.new('{"d":"red","e":[1,2,3,4],"f":5}')
    expect(c.total).to eq(0)
  end
  it 'should return 6 for [1,"red",5]' do
    c = Counter.new('[1,"red",5]')
    expect(c.total).to eq(6)
  end
  it 'should return 4 for [1,{"c":"red","b":2},3]' do
    c = Counter.new('[1,{"c":"red","b":2},3]')
    expect(c.total).to eq(4)
  end
end

#describe Day12 do
#end
