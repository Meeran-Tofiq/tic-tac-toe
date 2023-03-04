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
        @@board_state = Array.new(3) {Array.new(3) {" "}}
    end

    def self.board_state=board_stt 
        @@board_state = board_stt
    end

    def self.board_state
        return @@board_state
    end

    def print_board
        @@board_state.each_with_index do |row, i|
            puts row[0] + "   |   " + row[1] + "   |   " + row[2]

            unless i == 2
                puts "---------------------"
            end
        end
    end

    def add_mark(x, y, mark)
        if @@board_state[x][y] == " "
            @@board_state[x][y] = mark
        else 
            puts "That position is taken, please choose another."
        end

        self.check_for_win(x, y, mark)
    end

    def self.get_empty_spots
        Board.board_state.reduce(Array.new) do |acc, row|
            row.each do |col|
                if col == " "
                    acc.push([Board.board_state.index(row), row.index(col)])
                end
            end
            acc
        end
    end

    def reset_board
        @@board_state = Array.new(3) {Array.new(3) {" "}}
    end

    # private
    def check_for_win(x, y, current_mark)
        win = false

        @@board_state[x].each do |mark|
            if mark != current_mark
                win = false
                break
            end

            win = true
        end

        unless win
            @@board_state.each do |row|
                mark = row[y]

                if mark != current_mark
                    win = false
                    break
                end

                win = true
            end
        end

        unless win
            if @@board_state[0][0] == @@board_state[1][1] && @@board_state[1][1] == @@board_state[2][2]
                win = true
            else @@board_state[0][2] == @@board_state[1][1] && @@board_state[1][1] == @@board_state[2][0]
                win = true
            end
        end

        return win
        
    end
end

class Player < Board
    def initialize(mark, first)
        @mark = mark
        @first = first
    end

    def add_mark(x, y)
        super(x, y, @mark)
    end

    def computer_select
        arr = Board.get_empty_spots

        p arr

        random = rand(arr.length())
        pos = arr[random]

        add_mark(pos[0], pos[1])
    end
end

puts "Hello there!"
game = Game.new
player = Player.new("x", false)
computer = Player.new("o", false)
board = Board.new

Board.board_state = [["o", "x", " "], ['x', 'o', 'x'], ['x', 'x', 'o']]
board.print_board
computer.computer_select
board.print_board
puts board.check_for_win(0, 0, "o")