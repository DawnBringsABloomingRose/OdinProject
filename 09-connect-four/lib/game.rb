class Game
  def initialize
    @board = Board.new
    @player1 = { id: "b", name: "black"}
    @player2 = { id: "r", name: "red" }
    @current_player = @player1
    @moves = 0
  end

  def start_game
    puts "welcome to connect 4"
    make_move
  end
  
  def make_move
    @board.print_board
    puts "it is #{@current_player[:name]}'s turn, please select a column to make your move"
    col = gets.chomp.to_i

    if col >= 7 || col < 0
      puts "invalid move! try again"
      return make_move
    end

    @board.add_piece(col, @current_player[:id])
    game_over?
  end

  def game_over?
    win = @board.check_win
    unless win
      @moves += 1
      @current_player = other_player
    else
      winner = 'black' if win == 'b'
      winner = 'red' if win == 'r'
      @board.print_board
      puts "Good job #{winner} you won!"
      return play_again
    end
    
    make_move
  end

  def other_player
    return @player1 if @current_player[:id] == 'r'
    @player2
  end

  def play_again
    puts "would you like to play again? Y/N"
    answer = gets.chomp.downcase
    new_game if answer == 'y'
  end

  def new_game
    @board = Board.new
    @current_player = @player1
    @moves = 0
    start_game
  end
end