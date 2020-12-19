#!/usr/bin/env ruby

example = File.open("day5/example.txt").read
input = File.open("day5/input.txt").read.split("\n").map(&:chomp)

class Seat
  attr_reader :number_of_rows, :row_code
  attr_reader :number_of_cols, :col_code

  def initialize(input)
    @row_code = input.slice(0..6).split('')
    @number_of_rows = 127
    
    @col_code = input.slice(7..-1).split('')
    @number_of_cols = 7
  end

  def row
    min = 0
    max = number_of_rows

    row_code.each do |front_or_back|
      case front_or_back
      when 'F'
        max = mid_point(min, max) - 1
      when 'B'
        min = mid_point(min, max)
      end
    end
    min
  end

  def col
    min = 0
    max = number_of_cols

    col_code.each do |left_or_right|
      case left_or_right
      when 'L'
        max = mid_point(min, max) - 1
      when 'R'
        min = mid_point(min, max)
      end
    end
    min
  end

  def seat_id
    (row * 8) + col
  end

  private

  def mid_point(min, max)
    min + ((max + 1 - min) / 2)
  end
end

booked_seats = input.map{ |code| Seat.new(code) }

# puts booked_seats.map(&:seat_id).max

# Part 2

booked_seats = input.map{ |code| Seat.new(code) }
booked_seats_hash = booked_seats.map { |seat| [seat.seat_id, seat] }.to_h

# (0..127).each do |row|
#   row_text = ""
#   (0..7).each do |col|
#     seat_id = (row * 8) + col
#     if booked_seats_hash[seat_id].nil?
#       row_text << "."
#     else
#       row_text << "*"
#     end
#   end
#   puts row_text
# end

# First 10 rows don't exist
# Last 20 rows don't exist

my_seat_id = nil
(10..106).each do |row|
  row_text = ""
  (0..7).each do |col|
    seat_id = (row * 8) + col
    if booked_seats_hash[seat_id].nil?
      row_text << "."
      my_seat_id = seat_id
    else
      row_text << "*"
    end
  end
  puts row_text
end

puts "My Seat: #{my_seat_id}"