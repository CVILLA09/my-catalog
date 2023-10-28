require 'rspec'
require_relative '../classes/genre'

describe Genre do
  let(:genre) { Genre.new('Action', 'Video Games') }

  describe '#initialize' do
    it 'creates a new Genre instance with valid attributes' do
      expect(genre).to be_an_instance_of(Genre)
      expect(genre.name).to eq('Action')
      expect(genre.category).to eq('Video Games')
      expect(genre.items).to be_empty
    end
  end
end
