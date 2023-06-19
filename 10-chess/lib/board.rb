require_relative 'pieces'

class Board
  include BasicSerializable
  attr_reader :black_pieces, :white_pieces, :black_deleted, :white_deleted
  def initialize
    @black_pieces = []
    @white_pieces = []
    @black_deleted = []
    @white_deleted = []

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

  def serialize 
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var).map {|i| i.serialize}
    end
    @@serializer.dump obj
  end

  def unserialize(string)
    string = string.to_s if string.is_a? Hash
    obj = @@serializer.parse(string)
    obj.keys.each do |key|
      valu = obj[key].map do |i|
        hash_piece = @@serializer.parse(i)
        piece = Object.const_get(hash_piece["class"]).new('black', [0,0])
        piece.unserialize(i)
        piece
      end
      instance_variable_set(key, valu)
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
    enemy_locations = []
    enemy_pieces.each do |i|
      enemy_locations.push(i.current_location) unless i.current_location == move
    end

    king_location = move if piece.is_a?(King)

    enemy_pieces.each do |piece_to_check|
      return true if piece_to_check.valid_move?(king_location, enemy_locations, ally_pieces)
    end
    return false
  end

  def is_check?(king_colour, piece_to_move = nil, move = nil)
    return check?(@black_pieces, @white_pieces, piece_to_move, move) if king_colour == 'black'
    return check?(@white_pieces, @black_pieces, piece_to_move, move) if king_colour == 'white'
  end

  def checkmate?(king_colour)
    if king_colour == 'black'
      ally_pieces = @black_pieces
      enemy_pieces = @white_pieces
    else
      ally_pieces = @white_pieces
      enemy_pieces = @black_pieces
    end

    ally_pieces.each do |piece|
      poss_moves = piece.possible_moves(ally_pieces, enemy_pieces)
      poss_moves.each do |move|
        return false unless check?(ally_pieces, enemy_pieces, piece, move)
      end
    end
    return true
  end

  def make_move(from, to, to_play)
    current_player = @black_pieces if to_play == 'black'
    current_player = @white_pieces if to_play == 'white'
    enemy_player = @black_pieces if to_play == 'white'
    enemy_player = @white_pieces if to_play == 'black'
    
    piece = current_player.find {|i| i.current_location == from}
    return 'none' unless piece
    return 'check' if is_check?(to_play, piece, to)
    return 'invalid' unless piece.valid_move?(to, current_player, enemy_player)
    piece.make_move(to, current_player, enemy_player)
    piece_to_delete = enemy_player.find {|i| i.current_location == to}
    
    @black_deleted.push(@black_pieces.delete(piece_to_delete)) if to_play == 'white' && piece_to_delete
    @white_deleted.push(@white_pieces.delete(piece_to_delete)) if to_play == 'black' && piece_to_delete

    return 'good'

  end

  def test_case_1
    @black_pieces[0].current_location = [4,5]
  end

  def test_case_2
    @black_pieces[0].current_location = [4,4]
    
    return is_check?('black', @black_pieces[0], [4,5])
  end

  def test_case_3
    @black_pieces = []
    @white_pieces = []
    king = King.new('black', [0,0])
    queen1 = Queen.new('white', [1,1])
    queen2 = Queen.new('white', [3, 3])
    pawn = Pawn.new('black', [6, 6])

    @black_pieces.push(king).push(pawn)
    @white_pieces.push(queen1).push(queen2)
    return checkmate?('black')
  end
end

#board = Board.new()
#ser = board.serialize
#board.unserialize(ser)
#board.print_board
