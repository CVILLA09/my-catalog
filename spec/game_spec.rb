require 'rspec'
require './classes/game'

describe Game do
  describe '#initialize' do
    it 'creates a new Game instance with valid attributes' do
      game = Game.new('2023/10/28', true) # Use the correct date format
      expect(game).to be_an_instance_of(Game)
      expect(game.last_played_at).to eq(Date.parse('2023/10/28'))
      expect(game.multiplayer).to be_truthy
    end
  end
end
