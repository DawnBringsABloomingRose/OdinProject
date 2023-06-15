class Board
  attr_accessor :pieces
  def initialize
    @pieces = Array.new(7, Array.new())
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
    return true if !(@pieces[col][row].nil?) && @pieces[col][row] == @pieces[col + 1][row] && @pieces[col][row] == @pieces[col + 2][row] && @pieces[col][row] == @pieces[col + 3][row]
    false
  end

  def check_diagonal(col, row)
    return true if !(@pieces[col][row].nil?) && @pieces[col][row] == @pieces[col + 1][row + 1] && @pieces[col][row] == @pieces[col + 2][row + 2] && @pieces[col][row] == @pieces[col + 3][row + 3]
    return true if !(@pieces[col][row].nil?) && @pieces[col][row] == @pieces[col - 1][row + 1] && @pieces[col][row] == @pieces[col - 2][row + 2] && @pieces[col][row] == @pieces[col - 3][row + 3]
    false
  end

  def add_piece(col, color) 
    @pieces[col].push(color)
  end
end