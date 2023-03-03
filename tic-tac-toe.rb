class Game
    @@player_score = 0
    @@computer_score = 0
    @@second_computer_score = 0

    def initialize
        current_board = Board.new
        current_board.print_board
    end
end

class Board
    attr_reader :board_state
    attr_writer :board_state
    def initialize
        @board_state = Array.new(3) {Array.new(3) {" "}}
    end

    def print_board
        @board_state.each_with_index do |row, i|
            puts row[0] + "   |   " + row[1] + "   |   " + row[2]

            unless i == 2
                puts "---------------------"
            end
        end
    end

    def add_mark(x, y, mark)
        if @board_state[x][y] == " "
            @board_state[x][y] = mark
        else 
            puts "That position is taken, please choose another."
        end

        self.check_for_win
    end

    def reset_board
        @board_state = Array.new(9)
    end

    # private
    def check_for_win(x, y, current_mark)
        win = false

        @board_state[x].each do |mark|
            if mark != current_mark
                win = false
                break
            end

            win = true
        end

        unless win
            @board_state.each do |row|
                mark = row[y]

                if mark != current_mark
                    win = false
                    break
                end

                win = true
            end
        end

        return win
        
    end
end

puts "Hello there!"
game = Game.new
board = Board.new
board.board_state = [["o", "x", " "], ['x', 'x', 'x'], ['o', ' ', ' ']]
board.print_board
puts board.check_for_win(0, 0, "o")