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

    def refactor_input(input)
        arr = input.upcase.split(" ")
        from = []
        from[0] = arr[0][0].ord - 65
        from[1] = 8 - arr[0][1].to_i
        to = []
        to[0] = arr[1][0].ord - 65
        to[1] = 8 - arr[1][1].to_i
        [from, to]
    end
end

game = Game.new
p game.refactor_input("A1 B4")