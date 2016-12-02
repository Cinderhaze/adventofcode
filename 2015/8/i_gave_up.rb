#!/usr/bin/env ruby

# shamelessly stolen from https://www.reddit.com/r/adventofcode/comments/3vw32y/day_8_solutions/?
# I can't figure out what is wrong with my solution... I'll have to use this to generate a count per input line to find out where my solution breaks...
code_chars = 0
real_chars = 0

esc_chars = 0

File.readlines("day8.input.txt").each do |line|
  line = line.chomp
  code_chars += line.length
  real_chars += eval(line).length

  esc_chars += line.dump.length
end

puts "Part 1:"
puts code_chars - real_chars

puts "Part 2:"
puts esc_chars - code_chars
