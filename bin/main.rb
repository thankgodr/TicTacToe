#!/usr/bin/env ruby
require_relative '../lib/game_logic.rb'
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'

class GameInterface
  @x_player = nil
  @o_player = nil
  @arr = nil
  @current_player = nil
  @game_logic = nil
  @board = nil

  def initialize
    system('clear')
    @x_player = Player.new(nil, 'X'.green)
    @o_player = Player.new(nil, '0'.red)
    @game_logic = GameLogic.new(@x_player, @o_player)
    @board = Board.new(@game_logic.arr)
    @arr = @game_logic.arr
  end

  def print_board
    puts @board.update_board(@game_logic.arr)
  end

  def get_cell(player)
    input = Integer(gets.chomp)
    cell = @game_logic.verify_inputs(input)
    if cell.zero?
      puts 'Invalid Cell Selected'
      puts 'Please input a valid cell!'
      get_cell(player)
    end
    @game_logic.integer_to_index(cell, player.mark)
    @game_logic.alternate_player(player)
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
      puts "#{player.name} it is your turn! Enter the number of the cell you want to mark"
      player = get_cell(player)
      system('clear')
      new_turn(player)
    end
    congrat_winner(player)
  end

  def congrat_winner(player)
    player = @game_logic.alternate_player(player)
    puts "Congrats #{player.name}, you won!"
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
    @o_player.name = @o_player_name

    puts 'Please enter Player two name'
    @x_player_name = gets.chomp.green
    while @x_player_name.empty?
      system('clear')
      puts 'Please enter Player two name'
      @x_player_name = gets.chomp
    end
    @x_player.name = @x_player_name
    assign_first_player
  end

  def assign_first_player()
    puts "Who is playing first? (Enter 1 for #{@o_player.name} or 2 for #{@x_player.name})"
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
      @o_player.at_turn = true
      new_turn(@o_player)
    elsif first_player == 2
      @x_player.at_turn = true
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
