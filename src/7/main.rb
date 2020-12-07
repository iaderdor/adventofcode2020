# frozen_string_literal: true

require_relative '../../lib/aoc'

def main
  puts "Test result: #{handler 'test.txt', 1}"
  puts "Result: #{handler 'input.txt', 1}"

  puts "Test result 2: #{handler 'test.txt', 2}"
  puts "Test result 2-2: #{handler 'test2.txt', 2}"
  puts "Result 2: #{handler 'input.txt', 2}"
end

def handler(file, exercise_part)
  rules = parse_lines file

  case exercise_part
  when 1
    get_available_number_of_bags rules
  when 2
    bags_inside_shiny rules
  end
end

def parse_lines(file)
  lines = Aoc.parse_file file
  result = {}
  lines.each do |line|
    result.merge! parse_line(line)
  end
  result
end

def parse_line(line)
  line = line.split ' bags contain '
  container_bag = line[0]
  content = []

  content_bag = line[1].tr('.', '')
  content_bag = content_bag.split(',')
  content_bag.each do |bag|
    bag.slice! ' bags'
    bag.slice! ' bag'
    bag.strip!
    count = bag.scan(/^\d+/)[0]
    bag_colour = bag.scan(/\w+ \w+$/)[0]
    content.append({ bag_colour.to_sym => count })
  end

  {
    container_bag.to_sym => content
  }
end

def get_available_number_of_bags(rules)
  results = []

  rules.each do |container_bag, _content|
    results.append contains_available_bag(rules, container_bag)
  end

  results.count { |val| val }
end

def contains_available_bag(rules, bag_colour)
  rules[bag_colour].each do |content_bag, _count|
    colour_to_check = content_bag.keys.first
    next if colour_to_check == 'no other'.to_sym ||
            rules[bag_colour].nil?

    if colour_to_check == 'shiny gold'.to_sym
      return true
    else
      result = contains_available_bag(rules, colour_to_check)
      return result if result

    end
  end
  false
end

def bags_inside_shiny(rules, bag_colour = 'shiny gold')
  bag_colour = bag_colour.to_sym unless bag_colour.is_a? Symbol
  count = 0

  rules[bag_colour].each do |bag|
    bag.each do |key, bag_count|
      count += if bag_count.nil?
                 0
               elsif rules[key].first.keys.first == 'no other'.to_sym
                 bag_count.to_i
               else
                 bag_count.to_i * bags_inside_shiny(rules, key) + bag_count.to_i
               end
    end
  end
  count
end
