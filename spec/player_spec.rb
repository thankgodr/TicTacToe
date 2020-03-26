require './lib/player'

RSpec.describe Player do
  describe 'Player' do
    let(:temp_name) { 'Richie' }
    let(:temp_mark) { 'X' }
    let(:player) { Player.new(temp_name, temp_mark) }

    it 'Assign Player Name' do
      expect(player.name).to eql(temp_name)
    end

    it 'Assign Player Name (Negative)' do
      expect(player.name).not_to eql('David')
    end

    it 'Assign Player mark' do
      expect(player.mark).to eql(temp_mark)
    end

    it 'Assign Player mark (Negative)' do
      expect(player.mark).not_to eql('O')
    end
  end
end
