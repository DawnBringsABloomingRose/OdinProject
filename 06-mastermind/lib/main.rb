require_relative 'code'
require_relative 'ai'
require_relative 'display'
require_relative 'game'

Display.new

#ai = Ai.new
#p ai.candidate_guesses.select {|i| i == 'lllg'.split('')}
#p ai.eliminate_guesses('rrgg'.split(''), [0,0]).length


