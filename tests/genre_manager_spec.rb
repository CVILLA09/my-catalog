require 'rspec'
require 'json'
require './classes/genre'
require './classes/genre_manager'

describe GenreManager do
  let(:genre_manager) { GenreManager.new }

  before(:each) do
    FileUtils.rm_f('genres.json')
    @initial_genres = []
  end

  describe '#add_genre' do
    it 'adds a new genre to the genre manager' do
      expect(genre_manager.genres).to be_empty

      genre_manager.add_genre('Action', 'Video Games')

      expect(genre_manager.genres).to_not be_empty
      expect(genre_manager.genres.first.name).to eq('Action')
      expect(genre_manager.genres.first.category).to eq('Video Games')

      expect(File.exist?('genres.json')).to be_truthy
      genre_data = JSON.parse(File.read('genres.json'))
      expect(genre_data.size).to eq(1)
      expect(genre_data.first['name']).to eq('Action')
      expect(genre_data.first['category']).to eq('Video Games')
    end
  end
end
