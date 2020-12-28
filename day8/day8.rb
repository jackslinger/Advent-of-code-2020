#!/usr/bin/env ruby

input = File.open("day8/input.txt").read.split("\n").map(&:chomp)
example = File.open("day8/example.txt").read.split("\n").map(&:chomp)

class Instruction
  attr_accessor :instruction, :param

  def initialize(line)
    @instruction = line.slice(0..2)
    @param = line.slice(4..-1).to_i
  end

  def to_s
    "#{instruction} #{param}"
  end
end

class Computer
  attr_accessor :instructions
  attr_reader :accumulator, :pointer

  def initialize(program)
    @instructions = program.map{ |line| Instruction.new(line) }
    @previous_instructions = []
    @pointer = 0
    @accumulator = 0
  end

  def run
    while @previous_instructions == @previous_instructions.uniq
      return true if pointer == instructions.size
      execute
      @previous_instructions << @pointer
    end
    false
  end

  private

  def execute
    case current_instruction.instruction
    when "acc"
      @accumulator += current_instruction.param
      @pointer += 1
    when "jmp"
      @pointer += current_instruction.param
    when "nop"
      @pointer += 1
    end
  end

  def current_instruction
    instructions[pointer]
  end
end

computer = Computer.new(example)
computer.run
puts computer.accumulator

# Part 2

computer = Computer.new(input)

nop_instruction_indexes = computer.instructions.each_with_index.select { |instruction, i| instruction.instruction == 'nop' }.map { |_, i| i }.to_a
jmp_instruction_indexes = computer.instructions.each_with_index.select { |instruction, i| instruction.instruction == 'jmp' }.map { |_, i| i }.to_a

possible_programs = []

possible_programs += nop_instruction_indexes.map do |index|
  computer = Computer.new(input)
  new_instruction = computer.instructions[index]
  new_instruction.instruction = "jmp"
  computer.instructions[index] = new_instruction
  [computer.run, computer.accumulator]
end

possible_programs += jmp_instruction_indexes.map do |index|
  computer = Computer.new(input)
  new_instruction = computer.instructions[index]
  new_instruction.instruction = "nop"
  computer.instructions[index] = new_instruction
  [computer.run, computer.accumulator]
end

puts possible_programs.map{ |m| m.join(', ') }