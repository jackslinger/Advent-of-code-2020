#!/usr/bin/env ruby

input = File.open("day7/input.txt").read
example = File.open("day7/example.txt").read

class Edge
  attr_reader :container, :contained, :num

  def initialize(container, contained, num)
    @container = container
    @contained = contained
    @num = num
  end

  def to_s
    "#{container} contains #{num} #{contained} bag(s)"
  end
end

def read_rule(line)
  if line.match(/(.*) bags contain no other bags./)
    [$1, []]
  else
    line.match(/(.*) bags contain (.*)/)
    container = $1.chomp

    edges = $2.split(", ").map do |number_of_bags|
      number_of_bags.match(/(\d*) (.*) bag/)
      Edge.new(container, $2, $1.to_i)
    end

    [container, edges]
  end
end

def create_graph(input)
  vertices = []
  edges = []
  input.split("\n").each do |rule|
    vertex, edges_from_rule = read_rule(rule)
    vertices << vertex
    edges += edges_from_rule
  end
  [vertices, edges]
end

vertices, edges = create_graph(input)

def contained_by(edges, vertex)
  edges.select { |edge| edge.contained == vertex }.map { |edge| edge.container }
end

working_stack = ["shiny gold"]
valid_bags = []

while !working_stack.empty?
  new_vertices = contained_by(edges, working_stack.pop)
  working_stack += new_vertices
  working_stack.uniq!
  valid_bags += new_vertices
  valid_bags.uniq!
end

puts valid_bags.size


# Part 2

input = File.open("day7/input.txt").read
vertices, edges = create_graph(input)

def bags_within(edges, vertex)
  relevant_edges = edges.select { |edge| edge.container == vertex }
  if relevant_edges.empty?
    0
  else
    relevant_edges.map do |edge|
      (1 + bags_within(edges, edge.contained)) * edge.num
    end.inject(&:+)
  end
end

puts bags_within(edges, "shiny gold")


