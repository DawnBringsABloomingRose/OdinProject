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

    it "returns true for a valid move for a king" do
      king = King.new('black', [1,1])
      expect(king.valid_move?([2,1])).to eql(true)
    end

    it "returns false if a king tries to move more than 1 square" do
      king = King.new('black', [1,1])
      expect(king.valid_move?([2,3])).to eql(false)
    end

    it "returns true if a knight makes a valid move" do
      knight = Knight.new('black', [1,1])
      expect(knight.valid_move?([3,2])).to eql(true)
    end

    it "returns false if a knight makes an invalid move" do
      knight = Knight.new('black', [1,1])
      expect(knight.valid_move?([2,2])).to eql(false)
    end

    it "checks if other pieces are in the way of the move for the queen" do
      queen = Queen.new('black', [1,1])
      expect(queen.valid_move?([4,4], [[1,1], [2,3], [4,5]], [[0,0], [2,3], [4,2]])).to eql(true)
    end

    it "fails if other pieces are in the way of the move for the queen" do
      queen = Queen.new('black', [1,1])
      expect(queen.valid_move?([4,4], [[0,0], [2,2], [4,5]], [[0,0], [2,3], [4,2]])).to eql(false)
    end

    it "returns true unless there is an ally in the move location for a knight" do
      knight = Knight.new('black', [1,1])
      expect(knight.valid_move?([3,2], [[0,0], [2,2], [4,5]], [[0,0], [2,3], [4,2]])).to eql(true)
    end

    it "is able to detect if an ally is in the way of the knight" do
      knight = Knight.new('black', [1,1])
      expect(knight.valid_move?([3,2], [[3,2], [2,2], [4,5]], [[0,0], [2,3], [4,2]])).to eql(false)
    end

    it "returns true for the king if no ally is in the spot" do
      king = King.new('black', [1,1])
      expect(king.valid_move?([2,1], [[3,2], [2,2], [4,5]], [[0,0], [2,1], [4,2]])).to eql(true)
    end

    it "returns false if an ally is in the kings way" do
      king = King.new('black', [1,1])
      expect(king.valid_move?([2,1], [[3,2], [2,1], [4,5]], [[0,0], [2,1], [4,2]])).to eql(false)
    end

    it "returns true if a pawn makes a valid move" do
      pawn = Pawn.new('black', [0,1])
      expect(pawn.valid_move?([0,2])).to eql(true)
    end

    it "returns true if a pawn makes a valid move like moves two spaces at its first move" do
      pawn = Pawn.new('black', [0,1])
      expect(pawn.valid_move?([0,3])).to eql(true)
    end

    it "returns false if a pawn makes an invalid move" do
      pawn = Pawn.new('black', [0,1])
      expect(pawn.valid_move?([0,4])).to eql(false)
    end

    it "returns true if a pawn takes an enemy on an adjacent lane" do
      pawn = Pawn.new('black', [0,1])
      expect(pawn.valid_move?([1,2], [], [[1, 2]])).to eql(true)
    end

    it "returns false if a pawn attempts to capture a unit in front of it" do
      pawn = Pawn.new('black', [0,1])
      expect(pawn.valid_move?([0,2], [], [[0 , 2]])).to eql(false)
    end

    it "returns false if an ally is in the way" do
      pawn = Pawn.new('black', [0,1])
      expect(pawn.valid_move?([0,3], [[0,2]], [[0 , 2]])).to eql(false)
    end

    it "can succesfully en-passant" do
      pawn = Pawn.new('black', [0,1])
      pawn2 = Pawn.new('white', [1, 1])
      pawn2.made_passable
      expect(pawn.valid_move?([1,2], [], [pawn2])).to eql(true)
    end

    it "fail black for going the wrong way" do
      pawn = Pawn.new('black', [3,3])
      expect(pawn.valid_move?([3,2])).to eql(false)
    end

    it "fail white for going the wrong way" do
      pawn = Pawn.new('white', [3,3])
      expect(pawn.valid_move?([3,4])).to eql(false)
    end

    it "pass white for going the right way" do
      pawn = Pawn.new('white', [3,3])
      expect(pawn.valid_move?([3,2])).to eql(true)
    end
  end
end