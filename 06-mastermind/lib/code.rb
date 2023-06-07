class Code 
  COLOURS = 'yrgbpl'.split('')
  def initialize(code)
    @code = code if self.class.valid_code(code)
    @guesses = 0
  end

  def self.valid_code(code)
    return false unless code.length == 4
    
    code.each do |i|
      return false unless COLOURS.include?(i)
    end
    return true
  end

  def correct_guess?(guess)
  end

  def take_a_guess(guess)
    @guesses += 1
    return [4,4] if correct_guess?(guess)
    return number_right(guess)
  end

  def number_right(guess)
  end
end