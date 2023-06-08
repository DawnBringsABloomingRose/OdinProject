class Ai 
  COLOURS = 'yrgbpl'.split('')
  attr_accessor :candidate_guesses

  def initialize
    @potential_guesses = self.class.all_possible_guesses
    @candidate_guesses = @potential_guesses
  end

  def make_code
    code = []
    4.times do
      code.push(COLOURS[rand(6)])
    end
    code
  end

  def first_guess
    guess = []
    2.times do
      current_color = COLOURS[rand(6)]
      2.times { guess.push(current_color) }
    end
    guess
  end

  def code_check(guess, code)
    exact_right = 0
    half_right = 0
    guess.each_with_index do |i, peg|
      exact_right += 1 if i == code[peg]
    end
    guess.uniq.each do |i|
      half_right += [guess.count(i), code.count(i)].min
    end
    [exact_right, half_right - exact_right]
  end

  def eliminate_guesses(guess, feedback)
    @candidate_guesses.each_with_index do |cg, index|
      if code_check(guess, cg) == feedback
        next
      end
      @candidate_guesses[index] = nil
    end
    @candidate_guesses.compact!
    @candidate_guesses
  end

  def next_guess
    #for each potential guess
    #get max
    #get min of maxes
    #thats new guess
    max_scores = Hash.new
    
    @potential_guesses.each_with_index do |pg, index|
      scores = Hash.new(0)
      @candidate_guesses.each do |cg|
        scores[code_check(pg, cg)] += 1
      end
      temp = scores.max_by{|k,v| v}
      max_scores[pg] = temp[1]
    end
    max_scores.min_by{|k,v| v}[0]
  end

  def self.all_possible_guesses
    potential_guesses = []
    COLOURS.each do |i1|
      COLOURS.each do |i2|
        COLOURS.each do |i3|
          COLOURS.each do |i4|
            potential_guesses.push([i1, i2, i3, i4])
          end
        end
      end
    end
    potential_guesses
  end
end