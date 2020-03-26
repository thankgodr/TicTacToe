require_relative '../lib/game_logic'
require_relative '../lib/player'

RSpec.describe GameLogic do
  let(:game_logic) { GameLogic.new(Player.new('Richie', 'X'), Player.new('Felipe', 'O')) }
  describe 'Assign Players' do
    it 'Players are assign' do
      expect(game_logic.x_player).to be_a(Player)
      expect(game_logic.o_player).to be_a(Player)
    end

    it 'Players are assign (Nagetive)' do
      expect(game_logic.x_player).not_to be_a(Integer)
      expect(game_logic.o_player).not_to be_a(String)
    end
  end

  describe 'Array is correct' do
    it 'Array created' do
      expect(game_logic.arr).to be_a(Array)
    end

    it 'Array Length to be three' do
      expect(game_logic.arr.size).to eql(3)
    end

    let(:temp_arr) { game_logic.arr.all? { |x| x.is_a?(Array) } }
    it 'Its a Multidimentional Array' do
      expect(temp_arr).to eql(true)
    end

    it 'Its a Multidimentional Array (Negative)' do
      expect(temp_arr).not_to eql(false)
    end

    let(:temp_arr) { game_logic.arr.all? { |x| x.size == 3 } }
    it 'All sub array lenght should be 3' do
      expect(temp_arr).to eql(true)
    end

    it 'All sub array lenght should be 3 (Negative)' do
      expect(temp_arr).not_to eql(false)
    end
  end

  describe 'Game on initialize' do
    it 'Game on should be true until otherwise' do
      expect(game_logic.game_on).to eql(true)
    end

    it 'Game on should be true until otherwise (Negative)' do
      expect(game_logic.game_on).not_to eql(false)
    end
  end

  describe 'Game move initialize' do
    it 'Game_move should be a number' do
      expect(game_logic.game_moves).to be_a(Integer)
    end

    it 'Game_move should be a number (Negative)' do
      expect(game_logic.game_moves).not_to be_a(Array)
    end
  end

  describe 'Print board behaves as expected' do
    it 'Print Board should return a String' do
      expect(game_logic.print_board).to be_a(String)
    end

    it 'Print Board should return a String (Negative)' do
      expect(game_logic.print_board).not_to be_a(Array)
    end
  end

  describe 'Assign first player behaves as expected' do
    it 'Assign First player should return a Player' do
      expect(game_logic.assign_first_player(game_logic.x_player, game_logic.o_player, 1)).to be_a(Player)
    end

    it 'Assign First player should return the Appropraite player' do
      expect(game_logic.assign_first_player(game_logic.x_player, game_logic.o_player, 1)).to eql(game_logic.x_player)
      expect(game_logic.assign_first_player(game_logic.x_player, game_logic.o_player, 2)).to eql(game_logic.o_player)
    end
  end

  describe 'Verify input behaves as expected' do
    it 'Verify input should return a number' do
      expect(game_logic.verify_inputs(3)).to be_a(Integer)
    end

    it 'Verify input should return 0 if number is negative' do
      expect(game_logic.verify_inputs(-1)).to eql(0)
    end

    it 'Verify input should return 0 if number is grater than 9' do
      expect(game_logic.verify_inputs(11)).to eql(0)
    end
  end

  describe 'alternate player actually changes player' do
    it 'Alternate_player Shold return the next player' do
      expect(game_logic.alternate_player(game_logic.x_player)).to eql(game_logic.o_player)
      expect(game_logic.alternate_player(game_logic.o_player)).to eql(game_logic.x_player)
    end

    it 'Alternate_player Shold return the next player (Nagative)' do
      expect(game_logic.alternate_player(game_logic.x_player)).not_to eql(game_logic.x_player)
      expect(game_logic.alternate_player(game_logic.o_player)).not_to eql(game_logic.o_player)
    end
  end

  describe 'get_cell changes the value of array in place' do
    it 'Should change the value of the second element of the first array ' do
      game_logic.get_cell(2, game_logic.x_player)
      expect(game_logic.arr[0][1]).to eql(game_logic.x_player.mark)
    end

    it 'Should change the value of the second element of the first array (Negative) ' do
      game_logic.get_cell(2, game_logic.x_player)
      expect(game_logic.arr[0][1]).not_to eql(game_logic.o_player.mark)
    end
  end

  describe 'Game on and game moves are updated' do
    it 'Game on should be off when there is a winner' do
      game_logic.arr[0] = %w[X X X]
      game_logic.test_winner(game_logic.x_player)
      expect(game_logic.game_on).to eql(false)
    end

    it 'Game moves should be greater than 0' do
      game_logic.arr[0] = %w[X X 0]
      game_logic.test_draw
      expect(game_logic.game_moves).to be_within(1).of(8)
    end

    it 'Game moves should be greater than 0 (Negative)' do
      game_logic.arr[0] = %w[X X 0]
      game_logic.test_draw
      expect(game_logic.game_moves).not_to eql(0)
    end

    it 'Game moves should 0 when there is draw game' do
      game_logic.arr[0] = %w[X X O]
      game_logic.arr[1] = %w[O O X]
      game_logic.arr[2] = %w[X O X]
      game_logic.test_draw
      expect(game_logic.game_moves).to eql(0)
    end

    it 'Game moves should 0 when there is draw game (Negative)' do
      game_logic.arr[0] = %w[X X O]
      game_logic.arr[1] = %w[O O X]
      game_logic.arr[2] = %w[X O X]
      game_logic.test_draw
      expect(game_logic.game_moves).not_to be_within(1).of(8)
    end
  end

  describe 'Arr is reset' do
    it 'Arr should be reset on new game' do
      game_logic.arr[0] = %w[X X O]
      game_logic.new_game
      expect(game_logic.arr[0][2]).to eql(3)
    end

    it 'Arr should be reset on new game (Negative)' do
      game_logic.arr[0] = %w[X X O]
      game_logic.new_game
      expect(game_logic.arr[0][2]).not_to eql('X')
    end
  end
end
