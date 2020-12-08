# frozen_string_literal: true

require_relative '../../lib/aoc'
require 'set'

def main
  puts "Test result: #{handler 'test.txt', 1}"
  puts "Test result: #{handler 'input.txt', 1}"

  puts "Test result: #{handler 'test.txt', 2}"
  puts "Test result: #{handler 'input.txt', 2}"
end

def handler(file, exercise_number)
  lines = Aoc.parse_file file
  instructions = parse_opcodes lines

  case exercise_number
  when 1
    machine instructions
  when 2
    machine2 instructions
  end
end

def parse_opcodes(lines)
  program_list = []
  lines.each do |line|
    line = line.split ' '
    program_list.append(
      {
        opcode: line[0],
        value:  line[1].to_i
      }
    )
  end
  program_list
end

def machine(instructions)
  state = 0
  accum = 0
  exit_flag = false

  state_set = Set.new

  until exit_flag
    change = update_machine instructions[state], state
    state += change[:update_state]
    accum += change[:update_accum]
    exit_flag = true if state_set.include? state

    state_set.add state
  end

  accum
end

def machine2(instructions)
  state = 0
  accum = 0
  last_line = instructions.length
  exit_flag = false

  state_set = Set.new
  instructions_changed = Set.new

  exit_flag = false

  until exit_flag
    state = 0
    accum = 0
    state_set.clear

    loop_flag = false

    change_instructions(instructions, instructions_changed)

    until loop_flag
      change = update_machine instructions[state], state
      state += change[:update_state]
      accum += change[:update_accum]

      exit_flag = true if state >= last_line
      loop_flag = true if state_set.include?(state) || exit_flag

      state_set.add state
    end
  end

  accum
end

def change_instructions(instructions, instructions_changed)
  if instructions_changed.empty?
    line = 0
  else
    line = instructions_changed.max
    switch_opcode instructions[line]
    line += 1
  end
  (line..instructions.length).each do |instruction_line|
    jmp_condition = instructions[instruction_line][:opcode] == 'jmp'
    nop_condition = instructions[instruction_line][:opcode] == 'nop' &&
                    instructions[instruction_line][:value] != 0

    next unless jmp_condition || nop_condition

    switch_opcode instructions[instruction_line]
    instructions_changed.add instruction_line
    break
  end
end

def switch_opcode(instruction)
  case instruction[:opcode]
  when 'nop'
    instruction[:opcode] = 'jmp'
  when 'jmp'
    instruction[:opcode] = 'nop'
  end
end

def update_machine(instruction, state)
  case instruction[:opcode]
  when 'nop'
    nop_opcode
  when 'acc'
    acc_opcode instruction[:value], state
  when 'jmp'
    jmp_opcode instruction[:value], state
  end
end

def nop_opcode
  {
    update_state: 1,
    update_accum: 0
  }
end

def acc_opcode(value, _state)
  {
    update_state: 1,
    update_accum: value
  }
end

def jmp_opcode(value, _state)
  {
    update_state: value,
    update_accum: 0
  }
end
