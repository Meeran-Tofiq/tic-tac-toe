require 'pry-byebug'

class Game
    @@player_score = 0
    @@computer_score = 0
    @@second_computer_score = 0

    def initialize
        current_board = Board.new
        current_board.print_board

        play
    end

    def play
        player_human = prompt_player_human
        player_mark = promt_player_mark
        players_turn = prompt_player_first

        computer_mark = player_mark == "o" ? "x" : "o"
        computers_turn = !players_turn

        player = Player.new(player_mark)
        computer = Player.new(computer_mark)

        while true
            while players_turn
                if player_human
                    position = prompt_player_position

                    player_win = player.add_mark(position[0], position[1])
                    if player_win.nil?
                        next
                    elsif player_win
                        break
                    else
                        break
                    end
                else
                    if player.computer_select
                        player_win = true
                    end

                    break
                end
            end

            if computers_turn
                if computer.computer_select
                    computer_win = true
                end
            end
            
            players_turn = !players_turn
            computers_turn = !computers_turn

            Board.print_board
            sleep 1

            if player_win
                puts "You won!"
                break
            elsif computer_win
                puts "You lost!"
                break
            elsif Board.get_empty_spots == []
                puts "It's a draw!"
                break
            end
        end
        Board.reset_board
        
    end

    def prompt_player_human
        puts "Would you like to play yourself? Or pit two robots against each other? (y/...)"
        player_human = gets.chomp.downcase == "y" ? true : false 

        player_human
    end

    def promt_player_mark
        puts "What mark do you want to have? (o or x)"
        player_mark = gets.chomp.downcase

        while !(player_mark == "o" || player_mark == "x") 
            puts "Please choose either 1 or 2"
            player_mark = gets.chomp
        end

        player_mark
    end

    def prompt_player_first
        puts "Would you like to be first? (y/...)"
        player_first = gets.chomp == "y" ? true : false
    end

    def prompt_player_position
        puts "Where would you like to put your mark? (1-9)"
        pos = gets.chomp.to_i

        while pos > 9 || pos < 1
            puts "Please choose a viable position on the board"
            pos = gets.chomp.to_i
        end

        if pos < 4
            return [0, pos-1]
        elsif pos < 7
            return [1, pos-4]
        else
            return [2, pos-7]
        end
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

    def self.print_board
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
            return nil
        end

        self.check_for_win(x, y, mark)
    end

    def self.get_empty_spots
        row_counter = 0
        
        self.board_state.reduce(Array.new) do |acc, row|
            column_counter = 0
            row.each do |col|
                if col == " "
                    acc.push([row_counter, column_counter])
                end

                column_counter += 1
            end
            row_counter += 1
            acc
        end
    end

    def self.reset_board
        @@board_state = Array.new(3) {Array.new(3) {" "}}
    end

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
            if @@board_state[1][1] == current_mark
                if @@board_state[0][0] == @@board_state[1][1] && @@board_state[1][1] == @@board_state[2][2] 
                    win = true
                elsif (@@board_state[0][2] == @@board_state[1][1]) && (@@board_state[1][1] == @@board_state[2][0])
                    win = true
                end
            end
        end

        return win
        
    end
end

class Player < Board
    attr_reader :mark

    def initialize(mark)
        @mark = mark
    end

    def add_mark(x, y)
        super(x, y, @mark)
    end

    def computer_select
        arr = Board.get_empty_spots

        random = rand(arr.length())
        pos = arr[random]

        add_mark(pos[0], pos[1])
    end
end

puts "Hello there!"
game = Game.new
