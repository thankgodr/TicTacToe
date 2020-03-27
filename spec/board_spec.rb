require_relative '../lib/board'

RSpec.describe Board do
  let(:arr) do
    [[1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]]
  end
  let(:board) { Board.new(arr) }
  specify { expect(board).to be_a Board }
  specify { expect(board).not_to be_a String }

  describe 'Update board' do
    let(:board) { Board.new(arr) }
    it 'Update board should change the board based on the array' do
      board.arr[0] = %w[X X X]
      board.update_board(arr)
      expect(board.arr[0]).to eql(%w[X X X])
      expect(board.arr[0]).not_to eql([1, 2, 3])
    end
  end
end
