# frozen_string_literal: true

require_relative '../../lib/aoc'

def main
  puts "Test result: #{count_valid_passports('test2.txt')}"
  puts "Result: #{count_valid_passports('input.txt')}"
end

def parse_passports(file)
  pass_list = []
  lines = Aoc.parse_file(file)

  document = {}
  lines.each do |line|
    if line.empty?
      pass_list.append(document)
      document = {}
    end

    line = line.split ' '
    line.each do |field|
      aux = field.split(':')
      document[aux[0]] = aux[1]
    end
  end
  pass_list.append(document)

  pass_list
end

def count_valid_passports(file)
  pass_list = parse_passports file

  pass_list.reduce(0) do |sum, passport|
    sum += check_passport(passport) ? 1 : 0
  end
end

def check_passport(passport)
  mandatory_fields = %w[byr iyr eyr hgt hcl ecl pid]

  count = 0
  mandatory_fields.each do |field|
    count += 1 if passport.key?(field)
  end

  return false unless count == mandatory_fields.length

  check_year(passport['byr'], 1920, 2002) &&
    check_year(passport['iyr'], 2010, 2020) &&
    check_year(passport['eyr'], 2020, 2030) &&
    check_hgt(passport['hgt']) &&
    check_hcl(passport['hcl']) &&
    check_ecl(passport['ecl']) &&
    check_pid(passport['pid']) &&
    check_cid(passport['cid'])
end

def check_year(year, ystart, yend)
  year = year.to_i
  year >= ystart && year <= yend
end

def check_hgt(height)
  regex_valid = /^\d+(in|cm)/
  regex_num = /^\d+/

  return false if height.nil? && !height.match?(regex_valid)

  num = height.scan(regex_num)[0].to_i

  if height.match?(/in/)
    (num >= 59 && num <= 76)
  elsif height.match?(/cm/)
    (num >= 150 && num <= 193)
  end
end

def check_hcl(hair)
  regex = /#[0-9a-f]{6}/
  hair.match? regex
end

def check_ecl(eyes)
  valid_colours = %w[amb blu brn gry grn hzl oth]
  valid_colours.include? eyes
end

def check_pid(id)
  return false if id.nil?

  id.match?(/^\d{9}$/)
end

def check_cid(_id)
  true
end
