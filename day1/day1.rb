#!/usr/bin/env ruby

input = File.open("day1/input.txt").read.split().map(&:to_i)

# Part 1
pair = input.permutation(2).select { |first, second| first + second == 2020 }.first
puts pair[0] * pair[1]

# Part 2
pair = input.permutation(3).select { |first, second, third| first + second + third == 2020 }.first
puts pair[0] * pair[1] * pair[2]