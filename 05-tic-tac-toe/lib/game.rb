class Game
  attr_accessor :user1, :user2, :current_user, :board, :current_pieces

  def initialize(user1, user2)
    @current_pieces = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    @user1 = user1
    @user2 = user2
    @current_user = user1
    @board = Board.new
  end

  def place_piece(location)
    return false unless current_pieces[location / 3.floor][location % 3] == location

    current_pieces[location / 3.floor][location % 3] = current_user.symbol
  end

  def check_win
    3.times do |i|
      if current_pieces[i][0] == current_pieces[i][1] && current_pieces[i][0] == current_pieces[i][2]
        return current_pieces[i][0]
      elsif current_pieces[0][i] == current_pieces[1][i] && current_pieces[0][i] == current_pieces[2][i]
        return current_pieces[0][i]
      end
    end
    if current_pieces[1][1] == current_pieces[0][0] && current_pieces[1][1] == current_pieces[2][2]
      return current_pieces[1][1]
    elsif current_pieces[0][2] == current_pieces[2][0] && current_pieces[1][1] == current_pieces[2][0]
      return current_pieces[1][1]
    end

    false
  end

  def switch_user
    if current_user == user1
      self.current_user = user2
    else
      self.current_user = user1
    end
  end

  def run_game
    loop do
      @board.print_board(@current_pieces.flatten)
      puts "#{@current_user.name} please make your move"
      move = gets.chomp.to_i
      next unless place_piece(move)

      winner = check_win
      break if winner

      switch_user
    end
    current_user
  end
end
