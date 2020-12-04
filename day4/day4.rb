#!/usr/bin/env ruby

example = File.open("day4/example.txt").read
input = File.open("day4/input.txt").read

class Passport
  attr_reader :values

  def initialize(input)
    @values = {}
    input.split(" ").each do |pair|
      key, value = pair.split(":")
      values[key] = value
    end
  end

  def valid?
    all_required_keys? && byr_valid? && iyr_valid? && eyr_valid? && hgt_valid? && hcl_valid? && ecl_valid? && pid_valid?
  end

  def all_required_keys?
    required_keys.all? { |key| values.keys.include?(key) }
  end

  # byr (Birth Year)
  def byr_valid?
    values['byr'].size == 4 && values['byr'].to_i >= 1920 && values['byr'].to_i <= 2002
  end

  # iyr (Issue Year)
  def iyr_valid?
    values['iyr'].size == 4 && values['iyr'].to_i >= 2010 && values['iyr'].to_i <= 2020
  end

  # eyr (Expiration Year)
  def eyr_valid?
    values['eyr'].size == 4 && values['eyr'].to_i >= 2020 && values['eyr'].to_i <= 2030
  end

  # hgt (Height)
  def hgt_valid?
    match = values['hgt'].match /^(\d*)(cm|in)$/
    return false if match.nil?

    quantity = match[1].to_i
    unit = match[2]
    if unit == 'cm'
      quantity >= 150 && quantity <= 193
    elsif unit == 'in'
      quantity >= 59 && quantity <= 76
    end
  end

  # hcl (Hair Color)
  def hcl_valid?
    values['hcl'].match /^#[0-9a-f]{6}$/
  end

  # ecl (Eye Color)
  def ecl_valid?
    %w(amb blu brn gry grn hzl oth).include?(values['ecl'])
  end

  # pid (Passport ID)
  def pid_valid?
    values['pid'].match /^[0-9]{9}$/
  end

  # cid (Country ID)

  def required_keys
    %w(byr iyr eyr hgt hcl ecl pid)
  end
end

# passports = example.split("\r\n\r\n").map{ |input| Passport.new(input) }
passports = input.split("\n\n").map{ |input| Passport.new(input) }

puts passports.select { |passport| passport.all_required_keys? }.size

# Part 2

puts passports.select { |passport| passport.valid? }.size

