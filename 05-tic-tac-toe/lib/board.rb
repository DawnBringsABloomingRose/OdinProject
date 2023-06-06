# frozen_string_literal: true

class Board
  BLANK_ROW = '-----------------'
  def print_board(positions)
    3.times do |i|
      puts "  #{positions[i * 3]}  |  #{positions[i * 3 + 1]}  |  #{positions[i * 3 + 2]}  "
      puts BLANK_ROW unless i == 2
    end
  end
end
