#!/usr/bin/env ruby
require_relative '../lib/game_logic.rb'
require_relative '../lib/player.rb'
require_relative '../lib/colorize.rb'

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
    @arr = @game_logic.arr
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
      @game_logic.new_turn(@o_player)
    elsif first_player == 2
      @x_player.at_turn = true
      @game_logic.new_turn(@x_player)
    end
  end
end
GameInterface.new.display
