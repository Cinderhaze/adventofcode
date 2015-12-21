load 'Day13.rb'

sample = IO.read('sample.txt')

describe Inst do
  it "First actor is Alice in :Alice would gain 54 happiness units by sitting next to Bob." do
    inst = Inst.new('Alice would gain 54 happiness units by sitting next to Bob.')
    expect(inst.first).to eq('Alice')
  end
  it "Second actor is Bob in :Alice would gain 54 happiness units by sitting next to Bob." do
    inst = Inst.new('Alice would gain 54 happiness units by sitting next to Bob.')
    expect(inst.second).to eq('Bob')
  end
  it "Happiness should be 54 in :Alice would gain 54 happiness units by sitting next to Bob." do
    inst = Inst.new('Alice would gain 54 happiness units by sitting next to Bob.')
    expect(inst.happiness).to eq(54)
  end
  it "Happiness should be -79 in :Alice would lose 79 happiness units by sitting next to Carol." do
    inst = Inst.new('Alice would lose 79 happiness units by sitting next to Carol.')
    expect(inst.happiness).to eq(-79)
  end
end

describe Graph do
  it "should get max happiness of 330" do
    graph = Graph.new()
    sample.each_line do |line|
      graph.step(line)
    end
    graph.calc()
    expect(graph.longest_route).to eq(330)
    # I don't know how to test this unless I expose the 'loc' lookup
  end
end
