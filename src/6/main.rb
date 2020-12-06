# frozen_string_literal: true

require_relative '../../lib/aoc'
require 'set'

def main
  puts "Test result: #{handler 'test.txt', 1}"
  puts "Test result: #{handler 'input.txt', 1}"

  puts "Test result: #{handler 'test.txt', 2}"
  puts "Test result: #{handler 'input.txt', 2}"
end

def handler(file, problem_number)
  group_list = parse_input(file)

  case problem_number
  when 1
    sum_of_any_counts(group_list)
  when 2
    sum_of_every_counts(group_list)
  end
end

def parse_input(file)
  lines = Aoc.parse_file file

  group_list = []
  group = []

  lines.each do |line|
    if line.empty?
      group_list.append group
      group = []
    else
      group.append line
    end
  end

  group_list.append group
end

def count_group_any_answers(group)
  set = Set.new

  group.each do |person|
    person.each_char do |value|
      set.add value
    end
  end

  set.size
end

def sum_of_any_counts(group_list)
  group_list.map! { |group| group = count_group_any_answers(group) }
  group_list.reduce(0) { |sum, value| sum += value.to_i }
end

def count_group_every_answers(group)
  table = {}

  group.each do |person|
    person.each_char do |char|
      if table.key?(char.to_sym)
        table[char.to_sym] += 1
      else
        table[char.to_sym] = 1
      end
    end
  end

  table.reduce(0) do |sum, value|
    sum += value[1] == group.length ? 1 : 0
  end
end

def sum_of_every_counts(group_list)
  group_list.map! { |group| group = count_group_every_answers(group) }
  group_list.reduce(0) { |sum, value| sum += value.to_i }
end
