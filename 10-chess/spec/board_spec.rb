require './lib/board'

describe Board do
    describe '#is_check?' do 
        it "returns true if the king is in check at the given momemt" do
            board = Board.new
            board.test_case_1
            expect(board.is_check?('black')).to eql(true)
        end

        it "returns true when a move would put yourself in check" do
            board = Board.new 
            expect(board.test_case_2).to eql(true)
        end

        it "returns false if no check is found" do
            board = Board.new
            expect(board.is_check?('black')).to eql(false)
        end
    end
end