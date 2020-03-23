#!/usr/bin/env ruby
class GameInterface
  @board = nil
  @x_player = nil
  @o_player = nil
  @arr = nil
  @current_player = nil
  @game_on = nil
  @game_moves = nil

  def initialize
    @game_moves = 0
    @game_on = true
    system('clear')
    @x_player = { 'name' => nil, 'at_turn?' => false, 'mark' => 'X'.green }
    @o_player = { 'name' => nil, 'at_turn?' => false, 'mark' => 'O'.red }
    array_new
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

  def print_board
    puts @board = "     #{@arr[0][0]} | #{@arr[0][1]} | #{@arr[0][2]}
    ___*___*___
     #{@arr[1][0]} | #{@arr[1][1]} | #{@arr[1][2]}
    ___*___*___
     #{@arr[2][0]} | #{@arr[2][1]} | #{@arr[2][2]} "
  end

  def verify_inputs
    input = Integer(gets.chomp)
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
      puts 'Invalid Cell Selected'
      puts 'Please input a valid cell!'
      verify_inputs
    end
  end
end

class GameInterface
  def alternate_player(player)
    if player['mark'] == @x_player['mark']
      @x_player['at_turn?'] = false
      @o_player['at_turn?'] = true
      player = @o_player
    else
      @x_player['at_turn?'] = true
      @o_player['at_turn?'] = false
      player = @x_player
    end
    player
  end

  def get_cell(player)
    cell = verify_inputs
    integer_to_index(cell, player['mark'])
    alternate_player(player)
  rescue ArgumentError
    puts 'Please enter a valid integer'
    new_turn(player)
  end

  def new_turn(player)
    test_draw
    test_winner(player)
    if @game_moves.zero?
      puts 'Its a draw'
      @game_on = false
      new_game
    end

    print_board
    if @game_on
      puts "#{player['name']} it is your turn! Enter the number of the cell you want to mark"
      player = get_cell(player)
      system('clear')
      new_turn(player)
    end
    congrat_winner(player)
  end

  def congrat_winner(player)
    player = alternate_player(player)
    puts "Congrats #{player['name']}, you won!"
    new_game
  end

  def new_game
    puts 'Do wou want to play it again? Y/N'
    input = gets.chomp
    if input == 'Y'
      @game_on = true
      array_new
      assign_first_player
    else
      puts 'Ok!'
      exit
    end
  end

  def display
    puts 'Please enter player one name'

    @o_player_name = gets.chomp.red
    while @o_player_name.empty?
      system('clear')
      puts 'Please enter Player one name'
      @o_player_name = gets.chomp
    end
    @o_player['name'] = @o_player_name

    puts 'Please enter Player two name'
    @x_player_name = gets.chomp.green
    while @x_player_name.empty?
      system('clear')
      puts 'Please enter Player two name'
      @x_player_name = gets.chomp
    end
    @x_player['name'] = @x_player_name

    assign_first_player
  end

  def assign_first_player()
    puts "Who is playing first? (Enter 1 for #{@o_player_name} or 2 for #{@x_player_name})"
    begin
      first_player = Integer(gets.chomp)
      if !first_player.positive? || first_player > 2
        puts 'Please Enter only 1 or 2'
        assign_first_player
      end
    rescue ArgumentError
      puts 'Please Enter only 1 or 2'
      assign_first_player
    end
    system('clear')
    if first_player == 1
      @o_player['at_turn?'] = true
      new_turn(@o_player)
    elsif first_player == 2
      @x_player['at_turn?'] = true
      new_turn(@x_player)
    end
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

  def test_winner_diagonal(_player)
    if @arr[0][0] == @arr[1][1] &&
       @arr[1][1] == @arr[2][2]
      @game_on = false
    elsif @arr[0][2] == @arr[1][1] &&
          @arr[1][1] == @arr[2][0]
      @game_on = false

    end
  end

  def test_winner(player)
    puts 'Test winner'
    @arr.each do |row|
      @game_on = false if row.all? { |i| i == row[0] }
    end
    transposed = @arr.transpose
    transposed.each do |column|
      @game_on = false if column.all? { |i| i == column[0] }
    end
    test_winner_diagonal(player)
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
end

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end
end

GameInterface.new.display
