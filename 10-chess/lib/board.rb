require_relative 'pieces'

class Board
  attr_reader :black_pieces, :white_pieces
  def initialize
    @black_pieces = []
    @white_pieces = []
    @log_of_moves = []

    #create pieces
    8.times do |i|
      @black_pieces.push(Pawn.new('black', [i,1]))
      @white_pieces.push(Pawn.new('white', [i,6]))
    end

    [0,7].each do |i|
      @black_pieces.push(Rook.new('black', [i,0]))
      @white_pieces.push(Rook.new('white', [i,7]))
    end

    [1,6].each do |i|
      @black_pieces.push(Knight.new('black', [i,0]))
      @white_pieces.push(Knight.new('white', [i,7]))
    end

    [2,5].each do |i|
      @black_pieces.push(Bishop.new('black', [i,0]))
      @white_pieces.push(Bishop.new('white', [i,7]))
    end

    @black_pieces.push(King.new('black',[4,0]))
    @black_pieces.push(Queen.new('black',[3,0]))
    @white_pieces.push(King.new('white',[4,7]))
    @white_pieces.push(Queen.new('white',[3,7]))
  end

  def print_board
    arr = Array.new(8) {Array.new(8) {"   "}}

    alp_line = "   A | B | C | D | E | F | G | H"

    @black_pieces.each {|i| arr[i.current_location[1]][i.current_location[0]] = " #{i.get_symbol} "}
    @white_pieces.each {|i| arr[i.current_location[1]][i.current_location[0]] = " #{i.get_symbol} "}
    puts alp_line
    puts " +---+---+---+---+---+---+---+---+"
    arr.each_with_index do |row, index|
      str = "#{8-index}|"
      empty_line = "-+"
      row.each do |tile|
        str += "#{tile}|"
        empty_line += "---+"
      end
      str += "#{8-index}"
      empty_line += "-"
      puts str
      puts empty_line
    end
    puts alp_line

  end

  def self_check?
  end
end

board = Board.new

board.print_board