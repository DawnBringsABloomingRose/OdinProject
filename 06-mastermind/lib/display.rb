class Display
  def initialize
    self.class.run_game
  end

  def self.run_game
    puts "Hello and welcome to Mastermind!\nType b to be a codebreaker, m for codemaker or r for rules"
    input = gets.chomp.downcase
    if input == 'r'
      print_rules
      run_game
      return
    end
    if input == 'm'
      puts "Please enter your code, 4 letters"
      puts "Colours can be Yellow, Red, Green, Blue, Purple or bLack."
      code = gets.chomp.downcase.split('')
      until Code.valid_code(code)
        puts "Invalid guess! It must be 4 letters and can only be the letters YGBPL"
        puts "Try again"
        code = gets.chomp.downcase.split('')
      end
      @game = Game.new(input, code)
      player_master
    end
    if input == 'b'
      @game = Game.new(input)
      player_breaker
    end
  end
  
  def self.print_rules
    puts "Rules are simple"
  end

  def self.player_master
    system("clear") || system("cls")
    puts "The AI will now guess your code..."
    sleep(1.5)
    feedback = @game.ai_play
    bot_wins(feedback) if feedback.is_a? Integer
    if feedback.is_a? Array
      puts "The bot guessed #{@game.prev_guesses[-1]} which is #{feedback[0]} exactly right and #{feedback[1]} somewhat right!"
      puts "Press enter to continue"
      gets.chomp
      player_master
    end
  end

  def self.bot_wins(feedback)
    puts "Good effort! The bot guessed your code #{@game.prev_guesses[-1]} in #{feedback} guesses"
    play_again
  end

  def self.player_breaker
    puts "Ok you're the breaker!" if @game.code.guesses == 0 
    puts "Colours can be Yellow, Red, Green, Blue, Purple or bLack."
    puts "You have used #{@game.code.guesses} guesses. Enter a guess:"
    guess = gets.chomp.downcase.split('')
    unless Code.valid_code(guess)
      puts "Invalid guess! It must be 4 letters and can only be the letters ygbpL"
      puts "Try again"
      player_breaker
      return
    end
    make_guess(guess)
  end

  def self.make_guess(guess)
    system("clear") || system("cls")
    correct = @game.make_guess(guess)

    game_over if correct.is_a? Integer
    good_guess(correct) if correct.is_a? Array
  end

  def self.good_guess(correct)
    puts "Good guess! You got #{correct[0]} exactly right and #{correct[1]} with the right colour but wrong spot!\n\n"
    puts 'your previous guesses were:'
    print_prev_guesses
    player_breaker
  end

  def self.game_over
    puts "Really good guess, you win!"
    play_again
  end

  def self.print_prev_guesses
    @game.prev_guesses.each {|n| puts "#{n[0] + n[1] + n[2] + n[3]}"}
  end

  def self.play_again
    puts "Would you like to play again? [Y/N]"
    answer = gets.chomp.downcase.split('')[0]
    run_game if answer == 'y'
  end
end