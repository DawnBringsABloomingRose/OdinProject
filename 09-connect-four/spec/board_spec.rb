require './lib/board'

describe Board do
  describe "#check_win" do
    it "returns false if no 4 pieces are aligned" do
      board = Board.new
      expect(board.check_win).to eql(false)
    end
  end
end