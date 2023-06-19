require_relative 'pieces'

class Board
  attr_reader :black_pieces, :white_pieces
  def initialize
    @black_pieces = []
    @white_pieces = []
    @log_of_moves = []

    #create pieces
    @black_pieces.push(King.new('black',[4,0]))
    @black_pieces.push(Queen.new('black',[3,0]))
    @white_pieces.push(King.new('white',[4,7]))
    @white_pieces.push(Queen.new('white',[3,7]))

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

  def check?(ally_pieces, enemy_pieces, piece = nil, move = nil)
    return unless ally_pieces[0].is_a?(King)
    king_location = ally_pieces[0].current_location

    if piece
      ally_locations = []
      ally_pieces.each do |i|
        ally_locations.push(move) if i == piece
        ally_locations.push(i.current_location) unless i == piece
      end
      ally_pieces = ally_locations
    end
    king_location = move if piece.is_a?(King)

    enemy_pieces.each do |piece_to_check|
      return true if piece_to_check.valid_move?(king_location, enemy_pieces, ally_pieces)
    end
    return false
  end

  def is_check?(king_colour, piece_to_move = nil, move = nil)
    return check?(@black_pieces, @white_pieces, piece_to_move, move) if king_colour == 'black'
    return check?(@white_pieces, @black_pieces, piece_to_move, move) if king_colour == 'white'
  end

  def test_case_1
    @black_pieces[0].current_location = [4,5]
  end

  def test_case_2
    @black_pieces[0].current_location = [4,4]
    
    return is_check?('black', @black_pieces[0], [4,5])
  end
end

board = Board.new


