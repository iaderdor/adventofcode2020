# frozen_string_literal: true

require_relative '../../lib/aoc'
require 'set'

def main
  puts "Max test ID: #{high_seat_id('test.txt')}"
  puts "Max ID: #{high_seat_id('input.txt')}"

  puts "My seat ID: #{get_my_seat('input.txt')}"
end

def parse_input(file)
  lines = Aoc.parse_file(file)

  lines.map { |line| get_seat line }
end

def get_seat(line)
  line = line.each_char.map { |x| to_bin x }.join
  {
    row:    line[0..6].to_i(2),
    column: line[7..9].to_i(2)
  }
end

def to_bin(char)
  case char
  when 'F', 'L'
    0
  when 'B', 'R'
    1
  end
end

def max_row(seat_list)
  seat_list.reduce(0) do |max, seat|
    sum = seat[:row] > max ? seat[:row] : max
  end
end

def max_column(seat_list)
  seat_list.reduce(0) do |max, seat|
    sum = seat[:column] > max ? seat[:column] : max
  end
end

def to_seat_id(seat_list)
  seat_list.map { |seat| seat[:row] * 8 + seat[:column] }
end

def high_seat_id(file)
  seat_list = parse_input file
  to_seat_id(seat_list).max
end

def get_my_seat(file)
  seat_list = parse_input file
  seat_id_list = Set.new(to_seat_id(seat_list))

  my_seat = seat_id_list.filter do |seat_id|
    !seat_id_list.include?(seat_id + 1) && seat_id_list.include?(seat_id + 2)
  end

  my_seat[0] + 1
end
