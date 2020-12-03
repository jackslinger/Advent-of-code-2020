#!/usr/bin/env ruby

example = File.open("day3/example.txt").read
input = File.open("day3/input.txt").read

class Map
  attr_reader :width, :height

  def initialize(input)
    @width = input.split("\n").first.chomp.size
    @height = input.split("\n").size
    @rows = input.split("\n").map do |row|
      row.chomp.split("")
    end
  end

  def [](x, y)
    @rows[y][x % width]
  end

  def trees_on_slope(right, down)
    x = 0
    y = 0

    tiles_on_route = []
    while y < height
      tiles_on_route << self[x,y]
      x += right
      y += down
    end
    tiles_on_route.select{ |tile| tile == '#' }.size
  end

end

map = Map.new(input)
puts map.trees_on_slope(3, 1)

# Part 2

puts [
  map.trees_on_slope(1, 1),
  map.trees_on_slope(3, 1),
  map.trees_on_slope(5, 1),
  map.trees_on_slope(7, 1),
  map.trees_on_slope(1, 2)
].inject(&:*)



