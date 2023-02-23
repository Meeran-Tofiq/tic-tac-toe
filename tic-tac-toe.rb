def Game
    @@player_score = 0
    @@computer_score = 0
    @@second_computer_score = 0

    def initialize
        current_board = Board.new
    end
end

def Board
    def initialize
        @board_state = Array.new(3) {Array.new(3)}
    end

    def add_mark(position, mark)
        if !@board_state[position]
            @board_state[position] = mark
        else 
            puts "That position is taken, please choose another."
        end

        self.check_for_win
    end

    def reset_board
        @board_state = Array.new(9)
    end
end