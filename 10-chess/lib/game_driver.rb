require_relative "game"

class Game_Driver
  def initialize 
    puts "Welcome to chess!\n"
    @game = nil
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

  def test_case_1
    @game.print_board
  end
end

game = Game_Driver.new
game.new_game
game.test_case_1
game.save_game
game.load_game

game.test_case_1