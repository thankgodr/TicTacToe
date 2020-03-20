#!/usr/bin/env ruby
class GameInterface
  @board = nil
  @x_player = nil
  @o_player = nil
  @arr = nil
  @current_player = nil
  @game_on = nil

  def initialize
<<<<<<< HEAD
    
=======
    @game_on = true
>>>>>>> 1802bd3846af735f4604b34e913a7a9d258d88eb
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

  def verifyInputs
    input = Integer(gets.chomp)
    if input < 4
      return input if @arr[0][input - 1].is_a?(Integer)
    elsif input < 7 && input > 3
      return input if @arr[1][input - 4].is_a?(Integer)
    else
      return input if @arr[2][input - 7].is_a?(Integer)
    end
    puts 'Invalid Cell Selected'
    verifyInputs
  end

  def change_player(player)
    cell = verifyInputs
    if player['mark'] == @x_player['mark']
      integer_to_index(cell, player['mark'])
      @x_player['at_turn?'] = false
      @o_player['at_turn?'] = true
      player = @o_player
    else
      integer_to_index(cell, player['mark'])
      @x_player['at_turn?'] = true
      @o_player['at_turn?'] = false
      player = @x_player
    end
    player
  rescue ArgumentError
    puts 'Please enter a valid integer'
    new_turn(player)
  end

  def new_turn(player)
    print_board
    puts "#{player['name']} it is your turn! Enter the number of the cell you want to mark"
    begin
      test_winner(player)
    end

    if @game_on
      player = change_player(player)
      system('clear')
      new_turn(player)
    end

    puts "Congrats #{player['name']}, you won!"
    puts 'Do wou want to play it again? Y/N'
    input = gets.chomp
    if input == 'Y'
      @game_on == true
      array_new
      assign_first_player
    else
      puts 'Ok!'
      sleep 10
    end
  end

  def display
    puts 'Please enter Player one name'

    @o_player_name = gets.chomp
    while @o_player_name.empty?
      system('clear')
      puts 'Please enter Player one name'
      @o_player_name = gets.chomp
    end
    @o_player['name'] = @o_player_name

    puts 'Please enter Player two name'
    @x_player_name = gets.chomp
    while @x_player_name.empty?
      system('clear')
      puts 'Please enter Player two name'
      @x_player_name = gets.chomp
    end
    @x_player['name'] = @x_player_name

    puts "Who is playing first? (Enter 1 for #{@x_player_name} or 2 for #{@o_player_name})"
    assign_first_player
  end

  def assign_first_player()
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
    if first_player == 1
      @x_player['at_turn?'] = true
      new_turn(@x_player)
    elsif first_player == 2
      @o_player['at_turn?'] = true
      new_turn(@o_player)
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

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end

GameInterface.new.display
