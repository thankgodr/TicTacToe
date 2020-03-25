#!/usr/bin/env ruby
require_relative '../lib/game_logic.rb'
require_relative '../lib/player.rb'
require_relative '../lib/colorize.rb'

system('clear')
x_player = Player.new(nil, 'X'.green)
o_player = Player.new(nil, '0'.red)
game_logic = GameLogic.new(x_player, o_player)

puts 'Please enter player one name'
o_player_name = gets.chomp.red

while o_player_name.empty?
  system('clear')
  puts 'Please enter Player one name'
  o_player_name = gets.chomp
end

puts 'Please enter Player two name'
x_player_name = gets.chomp.green

while x_player_name.empty?
  system('clear')
  puts 'Please enter Player two name'
  x_player_name = gets.chomp
end

x_player.name = x_player_name
o_player.name = o_player_name

def select_cell(game_logic)
  begin
    input = Integer(gets.chomp)
    while game_logic.verify_inputs(input).zero?
      puts 'Invalid cell selected'
      puts 'Please enter a valid cell number'
      input = Integer(gets.chomp)
    end
    return input
  rescue StandardError
    puts 'Please Enter only number and valid cell number'
    return select_cell(game_logic)
  end
  input
end

def check_first_player
  first_player = Integer(gets.chomp)
  if !first_player.positive? || first_player > 2
    puts 'Please enter 1 or 2'
    return check_first_player
  end
  first_player
rescue ArgumentError
  puts 'Please enter only 1 or 2'
  check_first_player
end

def restart_game(o_player, x_player, game_logic)
  puts 'Do wou want to play it again? Y/N'
    input = gets.chomp
    if input.downcase == 'y'
      game_logic.new_game do
        start_game(o_player, x_player, game_logic)
      end
    else
      puts 'ok!'
      exit
    end
end

def middle_game(current_player, game_logic, o_player, x_player)
  while game_logic.game_on
    puts "#{current_player.name} it is your turn! Enter the number of the cell you want to mark"
    input = select_cell(game_logic)
    puts " inputs is #{input}"
    game_logic.get_cell(input, current_player)
    system('clear')
    current_player = game_logic.alternate_player(current_player)
    game_logic.new_turn(current_player) do
      if game_logic.game_moves.zero?
        puts 'Its a draw'
        game_logic.game_on = false
        restart_game(o_player, x_player, game_logic)
      end
      puts game_logic.print_board
    end
  end
end

def start_game(o_player, x_player, game_logic)
  puts "Who is playing first? (Enter 1 for #{o_player.name} or 2 for #{x_player.name})"
  first_player = check_first_player
  current_player = game_logic.assign_first_player(o_player, x_player, first_player)
  puts game_logic.print_board
  middle_game(current_player, game_logic,o_player, x_player,)
  game_logic.congrat_winner(current_player) do
    puts "Congrats #{current_player.name}, you won!"
    restart_game(o_player, x_player, game_logic)
  end
end

start_game(o_player, x_player, game_logic)
