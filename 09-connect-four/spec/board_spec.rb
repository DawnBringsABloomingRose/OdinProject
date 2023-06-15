require './lib/board'

describe Board do
  describe "#check_win" do
    it "returns false if no 4 pieces are aligned" do
      board = Board.new
      expect(board.check_win).to eql(false)
    end

    it "returns the winner's colour if they win on a horizontal" do
      board = Board.new
      4.times {|i| board.pieces[i][0] = 'b'}
      expect(board.check_win).to eql('b')
    end

    it "returns the winner's colour if they win on a vertical" do
      board = Board.new
      4.times {|i| board.pieces[0][i] = 'b'}
      expect(board.check_win).to eql('b')
    end

    it "returns the winner's colour if they win on a diagonal" do
      board = Board.new
      4.times {|i| board.pieces[i][i] = 'b'}
      expect(board.check_win).to eql('b')
    end

    it "returns the winner's colour if they win on a diagonal in the other direction" do
      board = Board.new
      4.times {|i| board.pieces[4-i][i] = 'b'}
      expect(board.check_win).to eql('b')
    end
  end
end