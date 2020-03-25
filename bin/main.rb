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


def gameMode(o_player,x_player,game_logic)
  puts "Who is playing first? (Enter 1 for #{o_player.name} or 2 for #{x_player.name})"
  first_player = game_logic.assign_first_player(o_player, x_player)
  puts game_logic.print_board
  puts game_logic.game_on
  while game_logic.game_on
    puts "#{first_player.name} it is your turn! Enter the number of the cell you want to mark"
    game_logic.get_cell(first_player)
    system('clear')
    first_player = game_logic.alternate_player(first_player)
    game_logic.new_turn(first_player){
      if game_logic.game_moves.zero?
        puts 'Its a draw'
        game_logic.game_on = false
        game_logic.new_game
      end 
      puts game_logic.print_board
    }
  end
  game_logic.congrat_winner(first_player){
   game_logic.new_game{
    gameMode(o_player,x_player,game_logic)
   }
  }
end

gameMode(o_player,x_player,game_logic)



