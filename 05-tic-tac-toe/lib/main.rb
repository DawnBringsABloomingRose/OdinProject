require_relative 'board'
require_relative 'player'
require_relative 'game'

puts 'Hello and welcome to tic-tac-toe'
puts 'Please enter player 1\'s name'
name1 = gets.chomp
puts 'Please enter player 1\'s symbol'
symbol1 = gets.chomp

puts 'Please enter player 2\'s name'
name2 = gets.chomp
puts 'Please enter player 2\'s symbol'
symbol2 = gets.chomp
if symbol2 == symbol1
  loop do
    puts 'Invalid symbol, please enter a unique one'
    symbol2 = gets.chomp
    break unless symbol1 == symbol2
  end
end

player1 = Player.new(symbol1, name1)
player2 = Player.new(symbol2, name2)

game = Game.new(player1, player2)
game_winner = game.run_game
puts "Congrats #{game_winner.name}"
