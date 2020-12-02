# frozen_string_literal: true

require_relative '../../lib/aoc'

def main
  lines = Aoc.parse_file('input.txt')
  testlines = Aoc.parse_file('test.txt')

  puts "Valid test passwords: #{count_valid_passwords(testlines, 1)}"
  puts "Valid tets passwords2: #{count_valid_passwords(testlines, 2)}"

  puts "Valid passwords: #{count_valid_passwords(lines, 1)}"
  puts "Valid passwords2: #{count_valid_passwords(lines, 2)}"
end

def count_valid_passwords(lines, method)
  lines.reduce(0) do |sum, line|
    sum += case method
           when 1
             valid_password?(line) ? 1 : 0
           when 2
             valid_password2?(line) ? 1 : 0
    end
  end
end

def parse_password(line)
  line = line.split(':')
  policy = line[0]

  {
    password:      line[1].strip,
    first_number:  policy.scan(/\d*-/)[0].scan(/^\d*/)[0].to_i,
    second_number: policy.scan(/-\d*/)[0].scan(/\d*$/)[0].to_i,
    char:          policy.scan(/.$/)[0]
  }
end

def valid_password?(line)
  line = parse_password(line)
  counts = line[:password].count(line[:char])

  counts >= line[:first_number] && counts <= line[:second_number]
end

def valid_password2?(line)
  line = parse_password(line)

  check1 = line[:password][line[:first_number] - 1] == line[:char]
  check2 = line[:password][line[:second_number] - 1] == line[:char]

  check1 ^ check2
end
