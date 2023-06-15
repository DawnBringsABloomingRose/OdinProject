class Board
  attr_accessor :pieces
  def initialize
    @pieces = Array.new(7) {Array.new}
  end

  def check_win
    @pieces.each_with_index do |column, index|
      column.each_with_index do |piece, row_ind|
        return piece if check_diagonal(index, row_ind) || check_hor(index, row_ind) || check_vert(index, row_ind)
      end
    end
    false
  end

  def check_vert(col, row)
    return true if !(@pieces[col][row].nil?) && @pieces[col][row] == @pieces[col][row + 1] && @pieces[col][row] == @pieces[col][row + 2] && @pieces[col][row] == @pieces[col][row + 3]
    false
  end

  def check_hor(col, row)
    return false if col+3 > 6 
    return true if !(@pieces[col][row].nil?) && @pieces[col][row] == @pieces[col + 1][row] && @pieces[col][row] == @pieces[col + 2][row] && @pieces[col][row] == @pieces[col + 3][row]
    false
  end

  def check_diagonal(col, row)
    return true if !(@pieces[col][row].nil?) && col+3 <= 6 && @pieces[col][row] == @pieces[col + 1][row + 1] && @pieces[col][row] == @pieces[col + 2][row + 2] && @pieces[col][row] == @pieces[col + 3][row + 3]
    return true if !(@pieces[col][row].nil?) && col-3 >= 0 &&  @pieces[col][row] == @pieces[col - 1][row + 1] && @pieces[col][row] == @pieces[col - 2][row + 2] && @pieces[col][row] == @pieces[col - 3][row + 3]
    false
  end

  def add_piece(col, color) 
    return "too large" if @pieces[col].length >= 6
    @pieces[col].push(color)
  end

  def print_board
    puts " 0 | 1 | 2 | 3 | 4 | 5 | 6 "
    6.times do |i|
      str = ""
      @pieces.each do |piece|
        str += "   |" if piece[5 - i].nil?
        str += " #{piece[5 - i]} |" unless piece[5 - i].nil?
      end
      puts str
    end
  end
end