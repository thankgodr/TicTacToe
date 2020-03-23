#!/usr/bin/env ruby
require_relative '../lib/game_logic.rb'

class GameInterface
  @board = nil
  @x_player = nil
  @o_player = nil
  @arr = nil
  @current_player = nil
  @game_logic = nil

  def initialize
    system('clear')
    @game_logic = GameLogic.new
    @arr = @game_logic.arr
    @x_player = @game_logic.x_player
    @o_player = @game_logic.o_player
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
    @game_logic.integer_to_index(cell, player['mark'])
    alternate_player(player)
  rescue ArgumentError
    puts 'Please enter a valid integer'
    new_turn(player)
  end

  def new_turn(player)
    @game_logic.test_draw
    @game_logic.test_winner(player)
    if @game_logic.game_moves.zero?
      puts 'Its a draw'
      @game_logic.game_on = false
      new_game
    end

    print_board
    if @game_logic.game_on
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
    if input.downcase == 'y'
      system('clear')
      @game_logic.game_on = true
      @game_logic.array_new
      @arr = @game_logic.arr
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
end

class String
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
