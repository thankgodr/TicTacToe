class GameLogic
  attr_accessor :arr
  attr_accessor :game_on
  attr_accessor :game_moves
  attr_reader :x_player
  attr_reader :o_player

  def initialize
    array_new
    @game_on = true
    @game_moves = 0
    @x_player = { 'name' => nil, 'at_turn?' => false, 'mark' => 'X'.green }
    @o_player = { 'name' => nil, 'at_turn?' => false, 'mark' => 'O'.red }
  end

  def array_new
    temp = []
    @arr = []
    (1..9).each do |i|
      if temp.size < 3
      else
        @arr << temp
        temp = []
      end
      temp << i
      @arr << temp if i == 9
    end
  end

  def test_winner(player)
    @arr.each do |row|
      @game_on = false if row.all? { |i| i == row[0] }
    end
    transposed = @arr.transpose
    transposed.each do |column|
      @game_on = false if column.all? { |i| i == column[0] }
    end
    test_winner_diagonal(player)
  end

  def test_winner_diagonal(_player)
    if @arr[0][0] == @arr[1][1] &&
       @arr[1][1] == @arr[2][2]
      @game_on = false
    elsif @arr[0][2] == @arr[1][1] &&
          @arr[1][1] == @arr[2][0]
      @game_on = false

    end
  end

  def test_draw
    @game_moves = 8
    @arr.each do |row|
      @game_moves -= 1 if row.any? { |i| i == @x_player['mark'] } && row.any? { |i| i == @o_player['mark'] }
    end
    transposed = @arr.transpose
    transposed.each do |column|
      @game_moves -= 1 if column.any? { |i| i == @x_player['mark'] } && column.any? { |i| i == @o_player['mark'] }
    end
    test_draw_diagonal
  end

  def test_draw_diagonal
    temp_array = [@arr[0][0], @arr[1][1], @arr[2][2]]
    temp_array_two = [@arr[0][2], @arr[1][1], @arr[2][0]]
    @game_moves -= 1 if temp_array.any? { |i| i == @x_player['mark'] } &&
                        temp_array.any? { |i| i == @o_player['mark'] }
    @game_moves -= 1 if temp_array_two.any? { |i| i == @x_player['mark'] } &&
                        temp_array_two.any? { |i| i == @o_player['mark'] }
  end

  def integer_to_index(input, mark)
    if input < 4
      @arr[0][input - 1] = mark
    elsif input < 7 && input > 3
      @arr[1][input - 4] = mark
    else
      @arr[2][input - 7] = mark

    end
  end
end
