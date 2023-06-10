class Word
  attr_reader :guess, :word

  def initialize
    @word = self.class.get_random_word
    @guess = Array.new(@word.length, '_')
  end

  def self.get_random_word
    viable_words = []
    File.foreach("wordlist.txt").each do |word|
      viable_words.push(word) if word.strip.length >= 5 && word.length <= 12
    end
    viable_words.sample.strip
  end

  def take_guess(char)
    @word.split('').each_with_index do |wordchar, i|
      guess[i] = char if wordchar == char
    end

    return "You guessed it! The word was #{word}" if won?
    return "#{char} was in there but does not quite solve it!\n\n" if word_includes?(char)
    return "#{char} was not quite in there!\n\n"
  end

  def neat_print_guess
    neat_print = ''
    @guess.each {|i| neat_print += i + ' '}
    neat_print
  end

  def won? 
    !@guess.include?('_')
  end

  def word_includes? (char)
    @guess.include?(char)
  end
end