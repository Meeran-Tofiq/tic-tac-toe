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

    private
    def check_for_win
        diagonal = Array.new
        win = Array.new(8)

        @board_state.each_with_index do |row, i|
            previous_mark = nil

            row.each_with_index do |mark, j|
                unless previous_mark
                    previous_mark = mark
                end
                
                if (i == j) || (i == 2 && j==0) || (i==0 && j==2) 
                    diagonal.push(mark)
                end

                if !(mark == previous_mark)
                    win[i] == false
                elsif win[i] != false
                    win[i] == true
                end

                previous_mark = mark
            end

            if win.includes?(true)
                return row[0]
            end

        end

        if (diagonal[0] == diagonal[2] && diagonal[2] == diagonal[4]) || (diagonal[1] == diagonal[2] && diagonal[2] == diagonal[3])
            return diagonal[2]
        end

        previous_mark = nil

        0..2.each do |col|
            0..2.each do |row|
                unless previous_mark
                    previous_mark == @board_state[row][col]
                end

                if @board_state[row][col] != previous_mark
                    win[col+3] = false
                elsif win[col+3] != false
                    win[col+3] = true
                end

                previous_mark = mark
            end
               
            if win.includes?(true)
                return @board_state[row][col]
            end
        end 

        return nil
    end
end

game = Game.new