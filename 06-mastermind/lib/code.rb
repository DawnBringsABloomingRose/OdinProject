class Code 
  COLOURS = 'yrgbpl'.split('')
  attr_accessor :code
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
    return true if guess == @code
    false
  end

  def take_a_guess(guess)
    @guesses += 1
    return [4,4] if correct_guess?(guess)
    return number_right(guess)
  end

  def number_right(guess)
    exact_right = 0
    half_right = 0
    guess.each_with_index do |i, peg|
      if i == code[peg]
        exact_right+=1
        next
      end
      half_right += 1 if code.include?(i)
    end
    [exact_right, half_right]
  end
end