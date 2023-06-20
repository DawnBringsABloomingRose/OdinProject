require_relative "board"

class Game
    include BasicSerializable

    attr_reader :to_play
    def initialize
        @board = Board.new
        @to_play = 'white'
        @history = []
    end

    def serialize
        obj = {}
        obj[:@board] = @board.serialize
        obj[:@to_play] = @to_play
        obj[:@history] = @history
        @@serializer.dump obj
    end

    def unserialize(string)
        obj = @@serializer.parse(string)
        @board = Board.new
        @board.unserialize(obj["@board"])
        @to_play = obj["@to_play"]
        @history = obj["@history"]
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

    def move(input_raw)
        moves = refactor_input(input_raw)
        code = @board.make_move(moves[0], moves[1], @to_play)

        if code == 'good'
            @history.push(input_raw)
            switch_side
            if @board.is_check?(@to_play)
                return 'mate' if @board.checkmate?(@to_play)
                return 'check'
            end
            return 'ok'
        elsif code == 'invalid'
            puts "That is not a legal move, please try again"
            return try_again
        elsif code == 'check'
            puts "That move would put you in check, please try again"
            return try_again
        elsif code == 'none'
            puts "There is no piece at #{input_raw.split(" ")[0]} please try again"
            return try_again
        end
    end

    def try_again
        puts "Enter the location of the piece you wish to move and where you would like to move it to"
        puts 'ie "A3 B2"'
        input = gets.chomp
        move(input)
    end
    
    def switch_side
        if @to_play == 'white'
            @to_play = 'black'
        else
            @to_play = 'white'
        end
    end
end
