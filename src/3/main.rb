# frozen_string_literal: true

require_relative '../../lib/aoc'

def main
  testlines = Aoc.parse_file('test.txt')
  lines = Aoc.parse_file('input.txt')

  puts "Trees found:#{count_trees_colision(testlines, 3, 1)}"
  puts "Trees found: #{count_trees_colision(lines, 3, 1)}"

  puts "Test multiplication result: #{multiply_trees_colisions(testlines)}"
  puts "Multiplication result: #{multiply_trees_colisions(lines)}"
end

def multiply_trees_colisions(lines)
  tree_list = []

  tree_list.append(count_trees_colision(lines, 1, 1))
  tree_list.append(count_trees_colision(lines, 3, 1))
  tree_list.append(count_trees_colision(lines, 5, 1))
  tree_list.append(count_trees_colision(lines, 7, 1))
  tree_list.append(count_trees_colision(lines, 1, 2))

  tree_list.reduce(1) { |mul, value| mul * value }
end

def count_trees_colision(lines, right_slope, down_slope)
  count = 0
  line_length = lines[0].length
  column = 0

  lines.each_with_index do |line, index|
    next if index % down_slope != 0

    count += 1 if line[column] == '#'
    column = (column + right_slope) % line_length
  end

  count
end
