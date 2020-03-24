class Board
    attr_accessor :arr
    attr_accessor :board
    def initialize(arr)
        @arr = arr
        update_board(@arr)
    end

    def update_board(arr)
        @arr = arr
        @board = "     #{@arr[0][0]} | #{@arr[0][1]} | #{@arr[0][2]}
     ___*___*___
     #{@arr[1][0]} | #{@arr[1][1]} | #{@arr[1][2]}
     ___*___*___
     #{@arr[2][0]} | #{@arr[2][1]} | #{@arr[2][2]} "
    end

end