require_relative "board"

class Game
    include BasicSerializable
    def initialize
        @board = Board.new
        @to_play = 'white'
    end

    def serialize
        obj = {}
        obj[:@board] = @board.serialize
        obj[:@to_play] = @to_play
        @@serializer.dump obj
    end

    def unserialize(string)
        obj = @@serializer.parse(string)
        @board = Board.new
        @board.unserialize(obj["@board"])
        @to_play = obj["@to_play"]
    end

    def print_board
        @board.print_board
    end
end