require_relative '../lib/player'

RSpec.describe Player do
  describe 'Player' do
    let(:temp_name) { 'Richie' }
    let(:temp_mark) { 'X' }
    let(:player) { Player.new(temp_name, temp_mark) }
    specify { expect(player).to be_a Player }
    specify { expect(player).not_to be_a String }

    it 'Assign Player Name' do
      expect(player.name).to eql(temp_name)
      expect(player.name).not_to eql('David')
    end

    it 'Assign Player mark' do
      expect(player.mark).to eql(temp_mark)
      expect(player.mark).not_to eql('O')
    end
  end
end
