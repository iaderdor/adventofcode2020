# frozen_string_literal: true

require_relative '../../lib/aoc'

def main
  puts "Test result: #{handler 'test.txt', 5, 1}"
  puts "Result: #{handler 'input.txt', 25, 1}"

  puts "Test result 2: #{handler 'test.txt', 5, 2}"
  puts "Result 2: #{handler 'input.txt', 25, 2}"
end

def handler(file, preamble_length, exercise_number)
  lines = Aoc.parse_file file
  lines.map!(&:to_i)

  case exercise_number
  when 1
    break_xmas lines, preamble_length
  when 2
    weakness_xmas lines, preamble_length
  end
end

def break_xmas(lines, preamble_length)
  lines[preamble_length..].each_with_index do |linevalue, idx|
    idx += preamble_length
    numbers = lines[idx - preamble_length..idx - 1]
    positive_count = 0

    # byebug if linevalue == 16
    numbers.each do |number|
      numbers_to_check = numbers.filter { |x| x != number }
      condition = numbers_to_check.any?(linevalue - number)
      positive_count += 1 if condition
    end

    return linevalue if positive_count.zero?
  end
end

def weakness_xmas(lines, preamble_length)
  number = break_xmas lines, preamble_length

  lines.each_with_index do |value1, idx|
    aux = [value1]

    lines[idx + 1..].each do |value2|
      aux.append value2
      break if aux.sum >= number
    end
    return aux.max + aux.min if aux.sum == number
  end

  nil
end

main if __FILE__ == $PROGRAM_NAME
