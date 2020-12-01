# frozen_string_literal: true

def main
  puts "First: #{multiply_2020_matches_double}"
  puts "Second: #{multiply_2020_matches_triple}"
end

def parse_file(file)
  lines = IO.readlines file

  lines.map!(&:strip)
  lines.map!(&:to_i)
end

def multiply_2020_matches_double
  lines = parse_file 'input.txt'

  lines.each do |value1|
    lines.each do |value2|
      return value1 * value2 if value1 + value2 == 2020
    end
  end
end

def multiply_2020_matches_triple
  lines = parse_file 'input.txt'

  lines.each do |value1|
    lines.each do |value2|
      next if value1 + value2 >= 2020

      lines.each do |value3|
        return (value1 * value2 * value3) if value1 + value2 + value3 == 2020
      end
    end
  end
end
