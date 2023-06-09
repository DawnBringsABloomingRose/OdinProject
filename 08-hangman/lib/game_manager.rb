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
    puts "what game would you like to open?" 
    print_saved_games
    name = gets.chomp.downcase
    name = "saved_games/#{name}.txt"
    file_contents = File.open(name, "r") {|file| file.read} if File.exists?(name)
    return unless file_contents
    @game.unserialize(file_contents)
    run_game
  end

  def print_saved_games
    saved_games = Dir.entries("saved_games")
    nice_text = ''
    saved_games.each do |game_name|
      next if game_name == '.' || game_name == '..'
      puts game_name.chomp('.txt')
    end
  end

  def save_game
    puts "what would you like to call your saved game?" 
    name = gets.chomp.downcase
    name = "saved_games/#{name}.txt"
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    File.open(name, "w") do |file|
      file.puts @game.serialize
    end
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