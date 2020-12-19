#!/usr/bin/env ruby

input = File.open("day6/input.txt").read

groups = input.split("\n\n").map{ |group| group.split("\n").map(&:chomp) }

def unique_questions_answered(group)
  group.map{ |individual| individual.split("") }.flatten.uniq
end

puts groups.map { |group| unique_questions_answered(group).size }.inject(&:+)

# Part 2

def questions_everyone_answered(group)
  group.map{ |individual| individual.split("") }.inject(&:&)
end

puts groups.map { |group| questions_everyone_answered(group).size }.inject(&:+)