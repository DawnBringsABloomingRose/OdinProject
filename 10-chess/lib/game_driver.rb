require_relative "game"

class Game_Driver
  def initialize 
    puts "Welcome to chess!\n"
    @game = Game.new
    puts "Type new or N to play a new game or type L or load to load one"
    response = gets.chomp.downcase
    new_game if response[0] == 'n'
    load_game if response[0] == 'l'

    @game.print_board
    run_game
  end

  def run_game
    @game.print_board
    puts "it is #{@game.to_play}'s turn! Enter the location of the piece you wish to move and where you would like to move it to"
    puts 'ie "A3 B2"'
    puts "or type 'menu' to go to the main menu"
    move = gets.chomp
    return main_menu if move.downcase == 'menu'
    response = @game.move(move)
    return main_menu if response == 'menu'
    if response == 'mate'
      puts "Checkmate! #{@game.switch_side} wins!"
    elsif response == 'check'
      system("clear") || system("cls")
      puts "#{@game.to_play} is in check!"
      return run_game
    elsif response == 'ok'
      system("clear") || system("cls")
      return run_game
    end
  end

  def main_menu
    puts "Main menu!"
    puts "Type Continue to go back, Save to save your game, Load to load a new game or Exit to exit"
    input = gets.chomp.downcase
    if input[0] == 'c'
      return run_game
    elsif input[0] == 's'
      save_game
    elsif input[0] == 'l'
      load_game
    elsif input[0] == 'e'
      return
    end
    main_menu
  end

  def new_game
    @game = Game.new
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

end

game = Game_Driver.new