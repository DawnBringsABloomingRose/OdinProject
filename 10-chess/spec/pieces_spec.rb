require './lib/pieces'

describe Piece do
  describe "#valid_move?" do
    it "returns true for a valid move the queen can make" do
      queen = Queen.new('black', [1,1])
      expect(queen.valid_move?([2,2])).to eql(true)
    end

    it "returns false for a move that would be out of bounds" do
      queen = Queen.new('black', [6,6])
      expect(queen.valid_move?([8,8])).to eql(false)
    end

    it "returns false for a non-linear queen move" do
      queen = Queen.new('black', [1,1])
      expect(queen.valid_move?([3,2])).to eql(false)
    end

    it "returns true for a valid horizontal move the queen can make" do
      queen = Queen.new('black', [1,1])
      expect(queen.valid_move?([2,1])).to eql(true)
    end

    it "returns true for a valid move the bishop can make" do
      bishop = Bishop.new('black', [1,1])
      expect(bishop.valid_move?([2,2])).to eql(true)
    end

    it "returns false for a horizontal or vertical bishop move" do
      bishop = Bishop.new('black', [1,1])
      expect(bishop.valid_move?([2,1])).to eql(false)
    end

    it "returns true for a valid move the rook can make" do
      rook = Rook.new('black', [1,1])
      expect(rook.valid_move?([3,1])).to eql(true)
    end

    it "returns false for a diagonal rook move" do
      rook = Rook.new('black', [1,1])
      expect(rook.valid_move?([3,3])).to eql(false)
    end
  end
end