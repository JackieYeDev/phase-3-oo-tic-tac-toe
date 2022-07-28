class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5], # Middle Row
        [6,7,8], # Bottom Row
        [0,3,6], # Left Column
        [1,4,7], # Middle Column
        [2,5,8], # Right Column
        [0,4,8], # \ Diagonal
        [2,4,6]  # / Diagonal
    ]
    attr_accessor :board, :turn_count, :current_player
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        @turn_count = 0
        @current_player = "X"
    end

    def display_board
        top_row = ""
        middle_row = ""
        bottom_row = ""
        @board.slice(0,3).map do |item|
            top_row << " #{item} "
        end
        while top_row.include?('  ')
            top_row = top_row.sub(/[\s]{2}/, " | ")
        end
        @board.slice(3,3).map do |item|
            middle_row << " #{item} "
        end
        while middle_row.include?('  ')
            middle_row = middle_row.sub(/[\s]{2}/, " | ")
        end
        @board.slice(6,3).map do |item|
            bottom_row << " #{item} "
        end
        while bottom_row.include?('  ')
            bottom_row = bottom_row.sub(/[\s]{2}/, " | ")
        end
        puts top_row,"-----------", middle_row, "-----------", bottom_row
        
    end

    def input_to_index (string)
        string.to_i - 1
    end

    def move (index, move)
        @board[index] = move
    end

    def position_taken?(index)
        @board[index] == " " ? false : true
    end

    def valid_move?(index)
        index.between?(0,8) ? position_taken?(index) ? false : true : false
    end

    def turn_count
        turn_count = board.filter {|item| item != " "}.count
    end

    def current_player
        self.turn_count.even? ? "X"  : "O"
    end

    def turn
        puts "Please enter input"
        input = gets
        index = input_to_index(input)
        if index.between?(0, 8)
            if valid_move?(index) 
                move(index, current_player)
                display_board
            else 
                self.turn
            end
        else 
            self.turn
        end
    end

    def won?
        # Check if "O" won
        # Check if "X" won
        # Check if tie 
        o_board = []
        x_board = []
        @board.each_with_index do |item, index|
            if item == "X"
                x_board.push(index)
            elsif item == "O"
                o_board.push(index)
            end
        end
        result = false
        # Check x board
        if result == false
            WIN_COMBINATIONS.each { |combo| (combo - x_board).empty? ? result = combo : nil }
        end

        # Check y board
        if result == false
            WIN_COMBINATIONS.each { |combo| (combo - o_board).empty? ? result = combo : nil }
        end
        result
    end
    def full?
        @board.find {|item| item == " " } ? false : true
    end
    def draw?
        (self.full? == true && self.won? == false) ? true : false
    end
    def over?
        self.draw? ? true : (self.won? ? true : false)
    end
    def winner
        self.won? ?  (self.turn_count.even? ? "O"  : "X") : nil
    end

    def play
        until self.over? 
            self.turn
        end
        self.winner ? (puts "Congratulations #{self.winner}!") : (puts "Cat's Game!")
    end
end