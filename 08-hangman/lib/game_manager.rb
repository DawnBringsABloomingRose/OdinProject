class Game_Manager

  def initialize 
    puts "Welcome to Hangman!\n"
    @game = nil
    @game_over = false
    @saved_game = ""
  end

  def play
    puts "Type new or n to start a new game, load or l to load a previous game or anything else to exit"
    response = gets.chomp.downcase
    new_game if response.split('')[0] == 'n'
    load_game if response.split('')[0] == 'l'
  end

  def new_game
    @game = Game.new
    run_game
  end

  def load_game
    @game = Game.new
    @game.unserialize(@saved_game)
    run_game
  end

  def save_game
    @saved_game = @game.serialize
  end

  def run_game
    until @game.game_over
      @game.current_status
      puts 'Take a guess, or type "menu" to return to the main menu, "save" to save or "exit" to exit'
      response = gets.chomp.downcase

      return if response == "exit"
      return play if response == "menu"
      next save_game if response == "save"

      puts @game.guess(response)
      puts ''
    end

    puts "Play again? Y/N"

    response = gets.chomp.downcase[0]
    play if response == 'y'
  end
end