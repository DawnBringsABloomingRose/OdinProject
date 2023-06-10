class Word

  def initialize
    @word = self.get_random_word
    @guess = ''
  end

  def self.get_random_word
    viable_words = []
    File.foreach("wordlist.txt").each do |word|
      viable_words.push(word) if word.strip.length >= 5 && word.length <= 12
    end
    viable_words.sample.strip
  end
end