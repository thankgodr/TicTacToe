require_relative '../lib/board.rb'

class GameLogic
  attr_accessor :arr
  attr_accessor :game_on
  attr_accessor :game_moves
  attr_reader :x_player
  attr_reader :o_player

  def initialize(player_one, player_two)
    array_new
    @game_on = true
    @game_moves = 0
    @x_player = player_one
    @o_player = player_two
    @board = Board.new(@arr)
  end

  def congrat_winner(player)
    player = alternate_player(player)
    puts "Congrats #{player.name}, you won!"
    yield
  end

  def new_game
    puts 'Do wou want to play it again? Y/N'
    input = gets.chomp
    if input.downcase == 'y'
      system('clear')
      @game_on = true
      array_new
      @arr = arr
      if block_given?
        yield
      end
    else
      puts 'Ok!'
      exit
    end
  end

  def print_board
    @board.update_board(@arr)
  end

  def assign_first_player(o_player, x_player)
    begin
      first_player = Integer(gets.chomp)
      if !first_player.positive? || first_player > 2
        puts 'Please Enter only 1 or 2'
        assign_first_player(o_player, x_player)
      end
    rescue ArgumentError
      puts 'Please Enter only 1 or 2'
      assign_first_player(o_player, x_player)
    end
    system('clear')
    if first_player == 1
      o_player.at_turn = true
      o_player
    elsif first_player == 2
      x_player.at_turn = true
      x_player
    end
  end

  def new_turn(player)
    test_draw
    test_winner(player)
    if block_given?
      yield
    end
  end

  def get_cell(player)
    input = Integer(gets.chomp)
    cell = verify_inputs(input)
    if cell.zero?
      puts 'Invalid Cell Selected'
      puts 'Please input a valid cell!'
      get_cell(player)
    end
    integer_to_index(cell, player.mark)
    alternate_player(player)
  rescue ArgumentError
    system('clear')
    puts 'Please enter a valid integer'
    new_turn(player)
  end

  def verify_inputs(input)
    if input < 4
      check_integer(input, 0, 1)
    elsif input < 7 && input > 3
      check_integer(input, 1, 4)
    else
      check_integer(input, 2, 7)
    end
  end

  def check_integer(number, index, offset)
    if @arr[index][number - offset].is_a?(Integer)
      number
    else
      0
    end
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
      @game_moves -= 1 if row.any? { |i| i == @x_player.mark } && row.any? { |i| i == @o_player.mark }
    end
    transposed = @arr.transpose
    transposed.each do |column|
      @game_moves -= 1 if column.any? { |i| i == @x_player.mark } && column.any? { |i| i == @o_player.mark }
    end
    test_draw_diagonal
  end

  def test_draw_diagonal
    temp_array = [@arr[0][0], @arr[1][1], @arr[2][2]]
    temp_array_two = [@arr[0][2], @arr[1][1], @arr[2][0]]
    @game_moves -= 1 if temp_array.any? { |i| i == @x_player.mark } &&
                        temp_array.any? { |i| i == @o_player.mark }
    @game_moves -= 1 if temp_array_two.any? { |i| i == @x_player.mark } &&
                        temp_array_two.any? { |i| i == @o_player.mark }
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

  def alternate_player(player)
    if player.mark == @x_player.mark
      @x_player.at_turn = false
      @o_player.at_turn = true
      player = @o_player
    else
      @x_player.at_turn = true
      @o_player.at_turn = false
      player = @x_player
    end
    player
  end
end
