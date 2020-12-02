#!/usr/bin/env ruby

example = File.open("day2/example.txt").read.split("\n")
input = File.open("day2/input.txt").read.split("\n")

# Part 1

def split_password_entry(entry)
  entry.match(/(\d*)-(\d*) ([a-z]): (\w*)/)
  min = $1
  max = $2
  char = $3
  password = $4
  return [min, max, char, password]
end

def valid_password_entry?(entry)
  min, max, char, password = split_password_entry(entry)
  password.count(char) >= min.to_i && password.count(char) <= max.to_i
end

puts input.select { |entry| valid_password_entry?(entry) }.size

# Part 2

def valid_by_new_policy?(entry)
  first_index, second_index, char, password = split_password_entry(entry)
  (password[first_index.to_i - 1] == char) ^ (password[second_index.to_i - 1] == char)
end

# example.each do |entry|
#   puts "#{entry.chomp} valid: #{valid_by_new_policy?(entry)}"
# end

puts input.select { |entry| valid_by_new_policy?(entry) }.size


