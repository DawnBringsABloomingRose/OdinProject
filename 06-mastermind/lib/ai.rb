class Ai 
  COLOURS = 'yrgbpl'.split('')

  def make_code
    code = []
    4.times do
      code.push(COLOURS[rand(6)])
    end
    code
  end
end