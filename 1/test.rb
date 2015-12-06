class Day1
  def initialize(input)
    floor=0
    input.each_char { |c|
      case c
       when '(' then floor +=1
       when ')' then floor -=1
      end
    }
    floor
  end
end
describe Day1 do
  it "should go up with a single (" do
    Day1.new('(') == 1 
  end
  it "should go down with a single (" do
    Day1.new(')') == -1 
  end
  it "should result in floor 0" do
    Day1.new('(())') == 0 
  end
  it "should also result in floor 0" do
    Day1.new('(())') == 0 
  end
  it "should result in floor 3" do
    Day1.new('(((') == 3 
  end
  it "should also result in floor 3" do
    Day1.new('(()(()(') == 3 
  end
  it "should also, also result in floor 3" do
    Day1.new('))(((((') == 3 
  end
  it "should result in floor -1" do
    Day1.new('())') == -1 
  end
  it "should also result in floor -1" do
    Day1.new('))(') == -1 
  end
  it "should result in floor -3" do
    Day1.new(')))') == -3 
  end
  it "should also result in floor -3" do
    Day1.new(')())())') == -3 
  end
end

#Actually execute things here.. figure out the best way to do this

input_name = 'day1.input.txt'

input = IO.read(input_name)
